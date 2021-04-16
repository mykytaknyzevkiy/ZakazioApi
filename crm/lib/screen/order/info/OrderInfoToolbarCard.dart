import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderStatus.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderInfoViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class OrderInfoToolbarCard extends StatelessWidget {
  final OrderInfoViewModel _viewModel =
      ViewModelProvider<OrderInfoViewModel>().build(() => OrderInfoViewModel());

  // ignore: unused_field
  final OrderModel _orderModel;

  OrderInfoToolbarCard(this._orderModel);

  @override
  Widget build(BuildContext context) => Card(
        elevation: 12,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Wrap(
              //spacing: 5,
              //runSpacing: 5,
              children: [
                setExecutorBtn(),
                cancelOrderBtn(),
                beExecutorBtn(),
                defuseExecutorBtn(),
                startWorkBtn(),
                doneWorkBtn(),
                feedbackClientBtn(),
                feedbackExecutorBtn()
              ],
            ),
          ),
        ),
      );

  setExecutorBtn() => _orderModel.setExecutorEnable
      ? Padding(padding: EdgeInsets.only(right: 5), child: MyButton(
      title: "Назначить исполнителя",
      onPressed: () => {_viewModel.onSelectExecutor()},
      isEnable: true))
      : Container();

  cancelOrderBtn() => _orderModel.cancelEnable
      ? Padding(padding: EdgeInsets.only(right: 5), child: MyButton(
      title: "Отменить",
      backgroundColor: Colors.redAccent,
      onPressed: () => {_viewModel.cancelOrder()},
      isEnable: true))
      : Container();

  beExecutorBtn() => _orderModel.beExecutorEnable
      ? Padding(padding: EdgeInsets.only(right: 5), child: MyButton(
      title: "Стать исполнителем",
      onPressed: () => {_viewModel.beExecutor()},
      isEnable: true))
      : Container();

  defuseExecutorBtn() => _orderModel.defuseMeExecutorEnable
      ? Padding(padding: EdgeInsets.only(right: 5), child: MyButton(
      title: "Отказаться",
      backgroundColor: Colors.red,
      onPressed: () => {
        _viewModel.onDefuseExecutor.add(true)
      },
      isEnable: true))
      : Container();

  startWorkBtn() => _orderModel.inWorkEnable
      ? Padding(padding: EdgeInsets.only(right: 5), child: MyButton(
      title: "Начать работу",
      backgroundColor: Colors.green[800]!,
      onPressed: () => {
        _viewModel.onStartWork.add(true)
      },
      isEnable: true))
      : Container();

  doneWorkBtn() => _orderModel.doneEnable
      ? Padding(padding: EdgeInsets.only(right: 5), child: MyButton(
      title: "Завершить работу",
      backgroundColor: Colors.green[800]!,
      onPressed: () => {
        _viewModel.doneOrder()
      },
      isEnable: true))
      : Container();

  feedbackClientBtn() => _orderModel.statusInfo() == OrderStatus.DONE &&
      _orderModel.feedbackAboutClient == null &&
      UserRepository.instance().myUserLiveData.value!.id == _orderModel.executor?.id
      ? Padding(padding: EdgeInsets.only(right: 5), child: MyButton(
      title: "Оценить заказчика",
      backgroundColor: Colors.green[800]!,
      onPressed: () => {
        _viewModel.onFeedback()
      },
      isEnable: true))
      : Container();

  feedbackExecutorBtn() => _orderModel.statusInfo() == OrderStatus.DONE &&
      _orderModel.feedbackAboutExecutor == null &&
      UserRepository.instance().myUserLiveData.value!.id == _orderModel.client.id
      ? Padding(padding: EdgeInsets.only(right: 5), child: MyButton(
      title: "Оценить исполнителя",
      backgroundColor: Colors.green[800]!,
      onPressed: () => {
        _viewModel.onFeedback()
      },
      isEnable: true))
      : Container();
}
