import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/OrderWorkerModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/order/MyOrderViewModel.dart';
import 'package:zakazy_crm_v2/screen/order/OrderViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/CityAutoTextField.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/order/OrderNewViewHolder.dart';
import 'package:zakazy_crm_v2/widget/order/OrderViewHolder.dart';

class MyOrderScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _AllOrderState(true);
}

class _AllOrderState extends HomeScreen<MyOrderScreen, MyOrderViewModel> {
  final bool isOnlyMy;

  final _searchFieldController = TextEditingController();

  late MyOrderViewModel _viewModel = viewModel();

  final _userRespository = UserRepository.instance();

  int _currentPage = 0;

  _AllOrderState(this.isOnlyMy) {
    _searchFieldController.addListener(() {
      _viewModel.search(_searchFieldController.text);
    });
    _viewModel.load(_currentPage);
  }

  @override
  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _createOrderButton(),
        Divider(height: 30, color: Colors.transparent),
        SizedBox(
          width: double.infinity,
          child: StreamBuilder<PagedListModel<OrderModel>>(
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
                        onSelect: (index) => _viewModel.load(index)
                    )
                  ],
                );
              else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        )
      ],
    );
  }

  @override
  Widget top() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        Text(
          (isOnlyMy ? "Мои " : "") + "Заказы",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
        ),
        _searchWidget(),
        isOnlyMy
            ? Container()
            : SizedBox(width: 300, child: CityAutoTextField((city) =>
            _viewModel.setCity(city)
        ),
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

  _searchWidget() => Padding(
    padding: EdgeInsets.only(right: 8),
    child: SizedBox(
      width: 500,
      child: TextFormField(
          controller: _searchFieldController,
          decoration: InputDecoration(
              icon: Icon(Icons.search),
              labelText: 'Поиск',
              border: OutlineInputBorder())),
    ),
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
    children: orders.map((e) => GestureDetector(
      onTap: () {
        ZakazioNavigator.pushWParams(
            "order/info", {"id": e.id});
      },
      child: OrderNewViewHolder(e),
    )).toList(),
  );

  @override
  MyOrderViewModel viewModelInstancer() => MyOrderViewModel();
}
