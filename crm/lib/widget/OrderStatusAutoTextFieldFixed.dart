import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderStatus.dart';
import 'package:zakazy_crm_v2/repository/AddressResponse.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:zakazy_crm_v2/repository/CategoryRepository.dart';
import 'package:zakazy_crm_v2/rest/CategoryRest.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class OrderStatusAutoTextField extends StatefulWidget {
  final Function(OrderStatus?) onSelect;
  OrderStatus? selectedCity;

  OrderStatusAutoTextField(this.onSelect);

  @override
  State<StatefulWidget> createState() =>
      _OrderStatusAutoTextField(onSelect, selectedCity);
}

class _OrderStatusAutoTextField extends State<OrderStatusAutoTextField>
    with WidgetsBindingObserver {
  final Function(OrderStatus? cityModel) onSelect;
  OrderStatus? selectedCity;

  final _list = OrderStatus.values;

  final FocusNode _focusNode = FocusNode();

  late ZTextField _textField = ZTextField(
      hint: "Статус",
      focusNode: _focusNode,
      txt: selectedCity?.name()
  );

  bool _isOpenList = false;

  _OrderStatusAutoTextField(this.onSelect, this.selectedCity);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isOpenList = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_textField, _isOpenList ? _listData() : Container()],
      ));

  Widget _listData() => Container(
    constraints: BoxConstraints(maxHeight: 250),
    decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8))),
    child: ListView(
      children: List.generate(_list.length + 1, (index) {
        if (index == 0) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                this._focusNode.unfocus();
                this._textField.setText("");
                this.onSelect(null);
                // this._focusNode.
              },
              child: ListTile(title: Text("Закрыть/Очистить")),
            ),
          );
        }
        final cityModel = _list[index - 1];
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              this._focusNode.unfocus();
              this._textField.setText(cityModel.name());
              this.onSelect(cityModel);
              // this._focusNode.
            },
            child: ListTile(
              title: Text(
                  cityModel.name(),
                  style: TextStyle(
                    color: cityModel.color()
                  ),
              ),
            ),
          ),
        );
      }),
    )
  );
}
