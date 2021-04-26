import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderStatus.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderClientInfoCard.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderCreateFeedbackScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderEditScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderExecutorInfoCard.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderFindExecutorScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderInfoToolbarCard.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderInfoViewModel.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderIntCommentWidget.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderLogsList.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderShareSumScreen.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/order/OrderFeedBackViewHolder.dart';
import 'package:zakazy_crm_v2/widget/order/OrderFileViewHolder.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:zakazy_crm_v2/widget/payment/OrderTransactionList.dart';

class OrderInfoScreen extends StatefulWidget {
  final int orderID;

  const OrderInfoScreen({required this.orderID});

  @override
  State<StatefulWidget> createState() => _OrderInfoScreenState(orderID);
}

class _OrderInfoScreenState
    extends HomeScreen<OrderInfoScreen, OrderInfoViewModel> {
  final int orderID;

  late OrderInfoViewModel _viewModel = viewModel();

  _OrderInfoScreenState(this.orderID) {
    _viewModel.loadData(orderID);
  }

  @override
  void initState() {
    super.initState();
    _viewModel.onDefuseExecutor.listen((value) {
      if (value == true) {
        showDefuseExecutorAlert();
      }
    });
    _viewModel.onStartWork.listen((value) {
      if (value == true) {
        showStartWorkAlert();
      }
    });
  }

  @override
  Widget rightDialog() {
    return StreamBuilder(
      stream: _viewModel.rightDialog,
      builder: (context, snapShot) {
        final data = snapShot.data;
        if (data == OrderInfoRightDialogType.EDIT) {
          return OrderEditScreen();
        } else if (data == OrderInfoRightDialogType.SELECT_EXECUTOR) {
          return OrderFindExecutorScreen();
        } else if (data == OrderInfoRightDialogType.SHARE_SUM) {
          return OrderShareSumScreen();
        } else if (data == OrderInfoRightDialogType.FEEDBACK) {
          return OrderCreateFeedbackScreen();
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget body() => StreamBuilder<OrderModel?>(
      stream: _viewModel.orderData,
      builder: (context, snapShot) {
        if (!snapShot.hasData)
          return Center(child: CircularProgressIndicator());

        final order = snapShot.requireData!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            info(order),
            (order.commentEnable) ? OrderInfoCommentWidget() : Container(),
            ([RoleType.ADMIN, RoleType.SUPER_ADMIN].contains(
                    UserRepository.instance().myUserLiveData.value!.roleInfo()))
                ? OrderTransactionList()
                : Container(),
            ([RoleType.ADMIN, RoleType.SUPER_ADMIN, RoleType.EDITOR].contains(
                    UserRepository.instance().myUserLiveData.value!.roleInfo()))
                ? OrderLogsList()
                : Container()
          ],
        );
      });

  Widget info(OrderModel order) => MediaQuery.of(context).size
      .width > phoneSize
      ? desktop(order)
      : mobile(order);

  desktop(OrderModel order) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderClientInfoCard(order.client),
            OrderExecutorInfoCard(order.executor)
          ],
        ),
      ),
      VerticalDivider(
        width: 25,
        color: Colors.transparent,
      ),
      Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            toShareSumBanner(order),
            toFreeExecutor(order),
            OrderInfoToolbarCard(order),
            data(order)
          ],
        ),
      )
    ],
  );

  mobile(OrderModel order) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      OrderClientInfoCard(order.client),
      OrderExecutorInfoCard(order.executor),
      toFreeExecutor(order),
      toShareSumBanner(order),
      OrderInfoToolbarCard(order),
      data(order)
    ],
  );

  @override
  int selectedIndex() => 1;

  @override
  Widget top() {
    return StreamBuilder<OrderModel?>(
      stream: _viewModel.orderData,
      builder: (context, snapShot) {
        if (!snapShot.hasData) return Container();

        final order = snapShot.requireData!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Заказ №${order.id}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
            ),
            Divider(
              height: 16,
              color: Colors.transparent,
            ),
            _status(order)
          ],
        );
      },
    );
  }

  _status(OrderModel order) => Container(
        width: 130,
        height: 30,
        decoration: BoxDecoration(
            color: order.statusInfo().color(),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Center(
          child: Text(
            order.statusInfo().name(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget data(OrderModel order) => Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: editInformationBtn(order),
              ),
              information(order)
            ],
          ),
        ),
      );

  Widget editInformationBtn(OrderModel order) {
    if (order.editEnable)
      return FloatingActionButton(
        onPressed: () => {_viewModel.onEdit()},
        child: Icon(Icons.edit),
      );
    else
      return Container();
  }

  Widget information(OrderModel order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Категория",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Divider(
          height: 10,
          color: Colors.transparent,
        ),
        Text(
          order.category.name,
          style: TextStyle(fontSize: 16),
        ),
        Divider(
          height: 16,
          color: Colors.transparent,
        ),
        Text(
          "Название",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Divider(
          height: 10,
          color: Colors.transparent,
        ),
        Text(
          order.title,
          style: TextStyle(fontSize: 16),
        ),
        Divider(
          height: 16,
          color: Colors.transparent,
        ),
        Text(
          "Описание",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Divider(
          height: 10,
          color: Colors.transparent,
        ),
        Text(
          order.content,
          style: TextStyle(fontSize: 16),
        ),
        Divider(
          height: 16,
          color: Colors.transparent,
        ),
        Text(
          "Предполагаемая дата завершения",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Divider(
          height: 10,
          color: Colors.transparent,
        ),
        Text(
          order.dateLine,
          style: TextStyle(fontSize: 16),
        ),
        Divider(
          height: 16,
          color: Colors.transparent,
        ),
        Text(
          "Сумма",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Divider(
          height: 10,
          color: Colors.transparent,
        ),
        Text(
          order.price.toString() + " RUB",
          style: TextStyle(fontSize: 16),
        ),
        Divider(
          height: 16,
          color: Colors.transparent,
        ),
        Text(
          "Регион",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Divider(
          height: 10,
          color: Colors.transparent,
        ),
        Text(
          order.city.region?.name??"",
          style: TextStyle(fontSize: 16),
        ),
        Divider(
          height: 16,
          color: Colors.transparent,
        ),
        Text(
          "Город",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Divider(
          height: 10,
          color: Colors.transparent,
        ),
        Text(
          order.city.name,
          style: TextStyle(fontSize: 16),
        ),
        Divider(
          height: 16,
          color: Colors.transparent,
        ),
        Text(
          "Файлы",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Divider(
          height: 10,
          color: Colors.transparent,
        ),
        Wrap(
            runSpacing: 20,
            spacing: 20,
            children: List.generate(
                order.files.length,
                (index) => OrderFileViewHolde(
                    fileName: order.files[index])
            )),
        Divider(
          height: 25,
          color: Colors.transparent,
        ),
        Text(
          "Отзывы",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Divider(
          height: 10,
          color: Colors.transparent,
        ),
        (order.feedbackAboutClient != null)
            ? OrderFeedBackViewHolder(order.feedbackAboutClient!)
            : Container(),
        Divider(
          height: 10,
          color: Colors.transparent,
        ),
        (order.feedbackAboutExecutor != null)
            ? OrderFeedBackViewHolder(order.feedbackAboutExecutor!)
            : Container()
      ],
    );
  }

  Widget orderCategory(OrderModel order) => Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Категория",
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              height: 25,
              color: Colors.transparent,
            ),
            Center(
                child: CircleAvatar(
              backgroundImage: NetworkImage(order.category.imageUrl != null
                  ? fileUrl(order.category.imageUrl!)
                  : "https://cdn1.iconfinder.com/data/icons/condominium-juristic-management-filled-outline/64/resolving_problems-resolving-problems-512.png"),
              radius: 35,
            )),
            Divider(
              height: 10,
              color: Colors.transparent,
            ),
            Center(
                child: Text(
              order.category.name,
              style: TextStyle(fontSize: 14),
            ))
          ],
        ),
      ));

  @override
  OrderInfoViewModel viewModelInstancer() => OrderInfoViewModel();

  showDefuseExecutorAlert() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Вы уверены что хотите отказаться?"),
            content: Text(
                "Если вы превысите лимит отказов на заказы - вы будете заблокированы"),
            actions: [
              FlatButton(
                  child: Padding(
                      padding: EdgeInsets.all(16), child: Text("Отменить")),
                  onPressed: () => {Navigator.of(context).pop()}),
              FlatButton(
                  child: Padding(
                      padding: EdgeInsets.all(16), child: Text("Отказаться")),
                  onPressed: () {
                    _viewModel.defuseExecutor();
                    Navigator.of(context).pop();
                  })
            ],
          ));

  showStartWorkAlert() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Начать работу?"),
            content:
                Text("Прежде чем начать работу советуем связаться с заказчиком"),
            actions: [
              FlatButton(
                  child: Padding(
                      padding: EdgeInsets.all(16), child: Text("Отменить")),
                  onPressed: () => {Navigator.of(context).pop()}),
              FlatButton(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Начать работу")),
                  onPressed: () {
                    _viewModel.startWork();
                    Navigator.of(context).pop();
                  }),
            ],
          ));

  toShareSumBanner(OrderModel order) => (order.toShareSum > 0 &&
          order.executor?.id ==
              UserRepository.instance().myUserLiveData.value!.id &&
          order.statusInfo() == OrderStatus.IN_WORK)
      ? Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Card(
            elevation: 4,
            color: Colors.redAccent,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Вам необходимо оплатить в систему часть стоимости заказа в размере ${order.toShareSum} руб.",
                      style: TextStyle(color: Colors.white),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.transparent,
                    ),
                    Text(
                      "Мы, вам доверяем и предоставляем доступ к заявкам:" +
                          "\n\n" +
                    "1. за % с договора т.е за результат." +
                    "\n2.По факту заключения вами договоров кол-во заказов в личном кабинете,  будет увеличено." +
                    "\n3. Наша команда, помогает вам затрачивая свое время и личные средства." +
                    "\n4. У вас есть от 2-7 дней чтобы заключить договора," +
                    "\n5. Мы вам в этом способствуем." +
                    "\n6. В случае низких показателей по заключению договоров по истечению срока," +
                    "заявки будут переданы другим партнерам, вам доступ будет закрыт и получение заказов " +
                    "временно приостановленно." +
                    "\n7. Взаимоуважение, и желание помочь купить клиенту , ваша величайшая ценность." +
                        "\n\n" +
                    "Важно! "+
                    "Если упускаются этапы общения, уменьшается частота заключенных сделок. " +
                    "Присматривайтесь к рекомендациям сервиса, это сэкономит вам время." +
                    "\nВыгодных вам сделок и процветания!",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Divider(
                      height: 25,
                      color: Colors.transparent,
                    ),
                    SizedBox(
                      width: 100,
                      child: SmallButton(
                          title: "Оплатить",
                          backgroundColor: accentColor,
                          foregroundColor: Colors.black,
                          onPressed: () => {
                                _viewModel.rightDialog
                                    .add(OrderInfoRightDialogType.SHARE_SUM)
                              },
                          isEnable: true),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      : Container();

  toFreeExecutor(OrderModel order) =>
      order.executor?.id ==
          UserRepository.instance().myUserLiveData.value!.id
          && order.statusInfo() == OrderStatus.PROCESS
      ? Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Card(
          elevation: 4,
          color: Colors.redAccent,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                "-Контакты заказчика открыты\n" +
                    "-У вас есть 2 часа, чтобы начать работу или отказаться от заказа. Иначе заказ с вас снимется\n" +
                    "-Выбирайте заказы внимательно. При более 4 отказов от заказов ваш аккаунт временно заблокируется\n",
                style: TextStyle(color: Colors.white),
              )
        ),
      ),
        ),
      )
      : Container();
}
