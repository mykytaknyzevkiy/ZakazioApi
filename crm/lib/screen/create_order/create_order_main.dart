// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_vm.dart';
import 'package:zakazy_crm_v2/screen/create_order/done_create_order.dart';
import 'package:zakazy_crm_v2/screen/create_order/fill_order_client_info.dart';
import 'package:zakazy_crm_v2/screen/create_order/fill_order_info.dart';
import 'package:zakazy_crm_v2/screen/create_order/fill_order_price.dart';
import 'package:zakazy_crm_v2/screen/create_order/select_order_category.dart';
import 'package:zakazy_crm_v2/screen/create_order/select_order_city.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class CreateOrderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateOrderState();
}

class _CreateOrderState
    extends HomeScreen<CreateOrderScreen, CreateOrderNewViewModel> {
  CreateOrderState _currentState = CreateOrderState.CATEGORY;

  late CreateOrderNewViewModel _viewModel = viewModel();

  CreateOrderStateScreen? _currentScreenState;

  LinearProgressIndicator buildProgressBar() {
    double value = 0;
    if (_viewModel.selectedChildCategory != null) value += 0.25;
    if (_viewModel.selectedCity != null) value += 0.25;
    if (_viewModel.orderInfo != null) value += 0.25;
    if (_viewModel.orderPriceData != null) value += 0.25;
    if (_viewModel.orderClientData != null) value += 0.25;

    return LinearProgressIndicator(
      value: value,
      backgroundColor: Colors.grey,
      minHeight: 15,
    );
  }

  Widget buildNextButton() => _currentState == CreateOrderState.DONE
  ? Container()
  : MyButton(
      title:
      (_currentState == CreateOrderState.CLIENT) ? "Опубликовать" : "Далее",
      onPressed: () => _currentScreenState?.nextClick(),
      isEnable: true
  );

  Widget buildBackButton() => _currentState == CreateOrderState.CATEGORY || _currentState == CreateOrderState.DONE
      ? Container()
      : FreeButton(
          title: "Назад",
          onPressed: () {
            final index = CreateOrderState.values.indexOf(_currentState) - 1;
            _setCurrentState(CreateOrderState.values[index]);
          },
          isEnable: true);

  _setCurrentState(CreateOrderState state) {
    setState(() {
      _currentState = state;
    });
  }

  @override
  Widget body() => SizedBox(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
          stream: _viewModel.isloading,
          builder: (context, snapShot) {
            if (snapShot.data == true)
              return Center(child: CircularProgressIndicator());
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 60 / 100,
                  child: SingleChildScrollView(child: buildContent()),
                ),
                Divider(
                  height: 25,
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildBackButton(),
                    VerticalDivider(
                      color: Colors.transparent,
                      width: 25,
                    ),
                    buildNextButton()
                  ],
                )
              ],
            );
          }));

  CreateOrderStateScreen buildContent() {
    switch (_currentState) {
      case CreateOrderState.CATEGORY:
        _currentScreenState = SelectOrderCategoryScreen(
            () => {_setCurrentState(CreateOrderState.ADDRESS)});
        break;
      case CreateOrderState.ADDRESS:
        _currentScreenState = SelectOrderCity(
            () => _setCurrentState(CreateOrderState.INFORMATION));
        break;
      case CreateOrderState.INFORMATION:
        _currentScreenState =
            FillOrderInfo(() => _setCurrentState(CreateOrderState.PRICE));
        break;
      case CreateOrderState.PRICE:
        _currentScreenState =
            FillOrderPrice(() => _setCurrentState(CreateOrderState.CLIENT));
        break;
      case CreateOrderState.CLIENT:
        _currentScreenState =
            FillOrderClientInfo(() {
              _viewModel.publish(context);
              _setCurrentState(CreateOrderState.DONE);
            });
        break;
      case CreateOrderState.DONE:
        _currentScreenState =
            DoneCreateOrder();
        break;
    }
    return _currentScreenState!;
  }

  @override
  Widget top() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Создать заказ",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
          ),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          buildProgressBar()
        ],
      );

  @override
  CreateOrderNewViewModel viewModelInstancer() => CreateOrderNewViewModel();
}

enum CreateOrderState {
  CATEGORY, // 25%
  ADDRESS, // 40%
  INFORMATION, // 60%
  PRICE, // 90%
  CLIENT, // 100%,
  DONE
}

class OrderInfoData {
  final String title;
  final String content;
  final List<PlatformFile> files;

  OrderInfoData(
      {required this.title, required this.content, required this.files});
}

class OrderPriceData {
  final double price;
  final String dateLine;

  OrderPriceData({required this.price, required this.dateLine});
}

class OrderClientData {
  final String firstName;
  final String lastName;
  final String middleName;
  final String email;
  final String phoneNumber;

  OrderClientData(
      {required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.email,
      required this.phoneNumber});
}

abstract class CreateOrderStateScreen extends StatelessWidget {
  final CreateOrderState state;
  final Function() _onNext;
  final String title;

  CreateOrderStateScreen(this.state, this.title, this._onNext);

  nextClick() {
    _onNext.call();
  }

  Widget content(BuildContext context);

  buildTitle() => Text(
        title,
        style: TextStyle(fontSize: 24),
      );

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          content(context)
        ],
      );
}
