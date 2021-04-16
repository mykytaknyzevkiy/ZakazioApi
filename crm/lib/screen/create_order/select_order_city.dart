import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_main.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_vm.dart';
import 'package:zakazy_crm_v2/widget/CityAutoTextField.dart';

class SelectOrderCity extends CreateOrderStateScreen {
  final _viewModel = ViewModelProvider<CreateOrderNewViewModel>()
      .build(() => CreateOrderNewViewModel());

  CityModel? _selectedCity;

  final _isError = BehaviorSubject<bool>.seeded(false);

  late CityAutoTextField _cityAutoField = CityAutoTextField((city) {
    _selectedCity = city;
    _isError.add(false);
  });

  SelectOrderCity(Function() onNext)
      : super(CreateOrderState.ADDRESS, "Введите данные адреса", onNext) {
    _selectedCity = _viewModel.selectedCity;
    _cityAutoField.selectedCity = _selectedCity;
  }

  @override
  Widget content(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
              stream: _isError,
              builder: (_, snapShot) => snapShot.data == true
                  ? Text("Заполните поле",
                      style: TextStyle(color: Colors.redAccent))
                  : Container()),
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          _cityAutoField
        ],
      );

  @override
  nextClick() {
    if (_selectedCity == null) {
      _isError.add(true);
      return;
    }

    _viewModel.selectedCity = _selectedCity;

    return super.nextClick();
  }

  close() {
    _isError.close();
  }
}
