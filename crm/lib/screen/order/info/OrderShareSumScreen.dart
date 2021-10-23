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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Оплатить комиссию за заказ",
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Divider(
              color: Colors.transparent,
              height: 20,
            ),
            Text("Вам необходимо оплать ${_viewModel.orderData.value!.toShareSum} руб."),
            Divider(
              color: Colors.transparent,
              height: 40,
            ),
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
        ),
      ),
    ),
  );

  _onSaveClick() async {
    _viewModel.shareSum();
  }

  _onCancelCLick() {
    _viewModel.rightDialog.add(null);
  }

  late MyButton payBtn = MyButton(
    title: "Оплатить",
    onPressed: () => _onSaveClick(),
    isEnable: true,
  );

  _btnColum() => SizedBox(
    width: 300,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        payBtn,
        FreeButton(
          title: "Отменить",
          onPressed: () => _onCancelCLick(),
          isEnable: true,
        )
      ],
    ),
  );
}