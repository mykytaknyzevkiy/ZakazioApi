import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_main.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_vm.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class FillOrderPrice extends CreateOrderStateScreen {
  final _viewModel = ViewModelProvider<CreateOrderNewViewModel>()
      .build(() => CreateOrderNewViewModel());

  final _priceField = ZTextField(
      hint: "Стоимость в руб.",
      keyBoardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly]);

  final _dateLineField = ZTextField(hint: "Ожидаемый срок завершения");

  FillOrderPrice(Function() onNext)
      : super(CreateOrderState.INFORMATION, "Бюджет", onNext) {
    final lastData = _viewModel.orderPriceData;
    if (lastData != null) {
      _priceField.setText(lastData.price.toString());
      _dateLineField.setText(lastData.dateLine);
    }
  }

  @override
  Widget content(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _priceField,
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          Text("Срок", style: TextStyle(fontSize: 24)),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          _dateLineField
        ],
      );

  @override
  nextClick() {
    if (!_priceField.text().isNumeric()) {
      _priceField.setError("");
      return;
    }
    if (_dateLineField.text().isEmpty) {
      _dateLineField.setError("");
      return;
    }

    _viewModel.orderPriceData = OrderPriceData(
        price: double.parse(_priceField.text()),
        dateLine: _dateLineField.text());

    return super.nextClick();
  }
}
