import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/factor/UserFactor.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/OrderWorkerModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_main.dart';
import 'package:zakazy_crm_v2/screen/order/OrderViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/CategoryAutoTextField.dart';
import 'package:zakazy_crm_v2/widget/CityAutoTextField.dart';
import 'package:zakazy_crm_v2/widget/CityAutoTextFieldFixed.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/OrderStatusAutoTextFieldFixed.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/order/OrderNewViewHolder.dart';
import 'package:zakazy_crm_v2/widget/order/OrderViewHolder.dart';

class AllOrderScreen extends StatefulWidget {
  final bool isOnlyMy;

  const AllOrderScreen({Key? key, this.isOnlyMy = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AllOrderState(isOnlyMy);
}

class _AllOrderState extends HomeScreen<AllOrderScreen, OrderViewModel> {
  final bool isOnlyMy;

  final _searchFieldController = TextEditingController();

  late OrderViewModel _viewModel = viewModel();

  final _userRespository = UserRepository.instance();

  int _currentPage = 0;

  _AllOrderState(this.isOnlyMy) {
    _searchFieldController.addListener(() {
      _viewModel.search(_searchFieldController.text);
    });
    _viewModel.load(_currentPage);
  }

  filters() => Card(
        elevation: 4,
        child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Фильтр", style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 25,
                ),
                _searchWidget(),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 300,
                  child: CityAutoTextFieldFixed(
                      (city) => _viewModel.setCity(city)),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 300,
                  child: CategoryAutoTextFieldFixed(
                      (category) => _viewModel.setCategory(category)),
                ),
                SizedBox(
                  height: 15,
                ),
                UserRepository.instance().myUserLiveData.value!.roleInfo() != RoleType.EXECUTOR
                ? SizedBox(
                  width: 300,
                  child: OrderStatusAutoTextField(
                          (status) => _viewModel.setStatus(status)),
                )
                : Container()
              ],
            )),
      );

  list() => StreamBuilder<PagedListModel<OrderModel>>(
        stream: _viewModel.orders,
        builder: (context, snapShot) {
          if (snapShot.hasData)
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _orderTableWidget(snapShot.requireData.content!),
                Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                PagesWidget(
                    pageLength: snapShot.requireData.totalPages,
                    currentPage: snapShot.requireData.number,
                    onSelect: (index) => _viewModel.load(index))
              ],
            );
          else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      );

  @override
  Widget body() =>
      MediaQuery.of(context).size.width > phoneSize ? _desktop() : _mobile();

  _desktop() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createOrderButton(),
          Divider(height: 30, color: Colors.transparent),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                      child: list()
                  )
                ),
              ),
              SizedBox(width: 25),
              filters()
            ],
          )
        ],
      );

  _mobile() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _createOrderButton(),
        Divider(height: 30, color: Colors.transparent),
        filters(),
        SizedBox(width: 25),
        list()
      ]);

  @override
  Widget top() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        Text(
          (isOnlyMy ? "Мои " : "") + "Заказы",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
        )
      ],
    );
  }

  @override
  int selectedIndex() => 1;

  /*@override
  Widget rightDialog() {
    return StreamBuilder<bool>(
      stream: _viewModel.isNewCreate,
      builder: (context, snapShot) {
        if (snapShot.data == true) {
          return AddOrderScreen();
        }
        return Container();
      },
    );
  } */

  _searchWidget() => SizedBox(
    width: 300,
    child: TextFormField(
        controller: _searchFieldController,
        decoration: InputDecoration(
            labelText: 'Поиск',
            border: OutlineInputBorder())),
  );

  _createOrderButton() =>
      (_userRespository.myUserLiveData.value! is OrderWorkerModel &&
              (_userRespository.myUserLiveData.value! as OrderWorkerModel)
                      .order
                      .enable ==
                  false)
          ? Container()
          : MyButton(
              title: "Создать новый заказ",
              isEnable: true,
              onPressed: () => {ZakazioNavigator.push(context, "order/create")},
            );

  _orderTableWidget(List<OrderModel> orders) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: orders.map((e) => OrderNewViewHolder(e)).toList(),
      );

  @override
  OrderViewModel viewModelInstancer() => OrderViewModel(isOnlyMy: isOnlyMy);
}
