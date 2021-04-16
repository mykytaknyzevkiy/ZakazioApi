import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/order/CreateOrderViewModel.dart';
import 'package:zakazy_crm_v2/screen/order/create/ClientInfoBox.dart';
import 'package:zakazy_crm_v2/screen/order/create/OrderInfoBox.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/order/CategorySelectWidget.dart';
import 'package:zakazy_crm_v2/widget/order/CitySelectWidget.dart';

class AddOrderBigScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddOrderBigScreenState();
}

class _AddOrderBigScreenState
    extends HomeScreen<AddOrderBigScreen, CreateOrderViewModel> {
  late CreateOrderViewModel _viewModel = viewModel();

  final _categoryInfoBox = CategorySelectWidget();

  final _clientInfoBox = ClientInfoBox();

  final _orderInfoBox = OrderInfoBox();

  final _cityInfoBox = CitySelectWidget();

  bool _isError = false;

  bool _isLoading = false;

  @override
  Widget body() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _orderInfoBox,
            Divider(
              height: 30,
              color: Colors.transparent,
            ),
            _cityInfoBox,
            Divider(
              height: 30,
              color: Colors.transparent,
            ),
            _categoryInfoBox,
            Divider(
              height: 30,
              color: Colors.transparent,
            ),
            _clientInfoBox,
            Divider(
              height: 30,
              color: Colors.transparent,
            ),
            _isError
                ? Text("Не известная ошибка, повторите попытку позже",
                    style: TextStyle(color: Colors.redAccent))
                : Container(),
            Divider(
              height: 30,
              color: Colors.transparent,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                _isLoading
                    ? CircularProgressIndicator()
                    : FreeButton(
                        title: "Отменить",
                        onPressed: () => _onCancelCLick(),
                        isEnable: true,
                      ),
                !_isLoading
                    ? VerticalDivider(
                        width: 20,
                      )
                    : Container(),
                !_isLoading
                    ? MyButton(
                        title: "Опубликовать",
                        onPressed: () => _onSaveClick(),
                        isEnable: true,
                      )
                    : Container(),
                _isLoading
                    ? VerticalDivider(
                        width: 5,
                      )
                    : Container()
              ],
            ),
            Divider(
              height: 30,
              color: Colors.transparent,
            )
          ],
        ));
  }

  @override
  int selectedIndex() => 1;

  _onSaveClick() async {
    bool isError = false;

    if (!_clientInfoBox.check()) {
      isError = true;
    }

    if (!_orderInfoBox.check()) {
      isError = true;
    }

    if (_cityInfoBox.selectedCity() == null) {
      isError = true;
    }

    if (_categoryInfoBox.selectedCategory() == null) {
      isError = true;
    }

    if (isError) return;

    setState(() {
      _isError = false;
      _isLoading = true;
    });

    final data = await _viewModel.saveOrder(
        title: _orderInfoBox.title(),
        content: _orderInfoBox.content(),
        price: _orderInfoBox.price(),
        dateLine: _orderInfoBox.dateLine(),
        city: _cityInfoBox.selectedCity()!,
        category: _categoryInfoBox.selectedCategory()!,
        clientFName: _clientInfoBox.clientFirstName(),
        clientLName: _clientInfoBox.clientLastName(),
        clientMName: _clientInfoBox.clientMiddleName(),
        clientPhone: _clientInfoBox.clientPhone(),
        clientEmail: _clientInfoBox.clientEmail());

    setState(() {
      _isLoading = false;
    });

    if (data) {
      ZakazioNavigator.push(context, "order/all");
    } else {
      setState(() {
        _isError = true;
      });
    }
  }

  _onCancelCLick() {
    ZakazioNavigator.push(context, "order/all");
  }

  @override
  Widget top() {
    return Text(
      "Создать заказ",
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
    );
  }

  @override
  CreateOrderViewModel viewModelInstancer() => CreateOrderViewModel();
}
