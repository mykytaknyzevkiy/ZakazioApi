import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/dashboard/NewDashboardScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderInfoViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';


class OrderShareSumScreen extends StatelessWidget {
  late OrderInfoViewModel _viewModel = ViewModelProvider<OrderInfoViewModel>().build(() => OrderInfoViewModel());

  final sumTextField = ZTextField(hint: "Введите сумму для перевода");

  double myBalance = 0;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height,
    child: Card(
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, bottom: 48, top: 48),
        child: FutureBuilder<double>(
            future: _viewModel.myBalance(),
            builder: (context, snapShot) {
              if (!snapShot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              myBalance = snapShot.requireData;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Оплатить за заказ",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Divider(
                    color: Colors.transparent,
                    height: 20,
                  ),
                  Text("Вам осталось оплать ${_viewModel.orderData.value!.toShareSum} руб.\nМожно оплачивать частями"),
                  Divider(
                    color: Colors.transparent,
                    height: 40,
                  ),
                  Text("Ваш баланс ${formatNumber(myBalance.toInt())} руб."),
                  Divider(
                    color: Colors.transparent,
                    height: 15,
                  ),
                  SmallButton(
                      title: "Пополнить баланс",
                      onPressed: () => {
                        ZakazioNavigator.push(context, "user/profile/my")
                      },
                      isEnable: true),
                  Divider(
                    color: Colors.transparent,
                    height: 25,
                  ),
                  sumTextField,
                  Divider(
                    color: Colors.transparent,
                    height: 25,
                  ),
                  StreamBuilder<bool>(
                    stream: _viewModel.exLoading,
                    builder: (context, snapShot) {
                      if (!snapShot.hasData || snapShot.requireData == false)
                        return _btnColum();
                      else
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                    },
                  )
                ],
              );
            }
        ),
      ),
    ),
  );

  _onSaveClick() async {
    bool isError = false;

    if (!sumTextField.text().isNumeric()) {
      isError = true;
      sumTextField.setError("не верный формат");
    } else if (double.parse(sumTextField.text()) >= myBalance) {
      isError = true;
      sumTextField.setError("превышен лимит");
    }

    if (isError)
      return;

    _viewModel.shareSum(double.parse(sumTextField.text()));
  }

  _onCancelCLick() {
    _viewModel.rightDialog.add(null);
  }

  _btnColum() => SizedBox(
    width: 300,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyButton(
          title: "Оплатить",
          onPressed: () => _onSaveClick(),
          isEnable: true,
        ),
        FreeButton(
          title: "Отменить",
          onPressed: () => _onCancelCLick(),
          isEnable: true,
        )
      ],
    ),
  );
}