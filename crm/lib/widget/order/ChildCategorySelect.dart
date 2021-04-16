import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/category/ChildCategoryModel.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class ChildCategorySelect extends StatefulWidget {
  final Function(ChildCategoryModel) onSelect;
  final ChildCategoryModel? selectedChild;

  const ChildCategorySelect(
      {Key? key, required this.onSelect, this.selectedChild})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _ChildCategorySelect(onSelect, selectedChild);
}

class _ChildCategorySelect extends State<ChildCategorySelect>
    with WidgetsBindingObserver {
  final Function(ChildCategoryModel) _onSelect;
  final ChildCategoryModel? _selectedChild;

  final FocusNode _focusNode = FocusNode();

  late ZTextField _searchField = ZTextField(
    hint: "Введите название",
    focusNode: _focusNode,
    onEdit: (txt) => {},
  );

  _ChildCategorySelect(this._onSelect, this._selectedChild);

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
        link: LayerLink(),
        child: SizedBox(
          width: double.infinity,
          child: _searchField,
        ),
      );
}
