import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class UserStatusSelectWidget extends StatefulWidget {
  final Function(String?) onSelected;
  final String? selectedStatus;

  const UserStatusSelectWidget({Key? key, required this.onSelected, this.selectedStatus}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserStatusSelectWidget(onSelected: onSelected, selectedStatus: selectedStatus);

}

class _UserStatusSelectWidget extends State<UserStatusSelectWidget> with WidgetsBindingObserver {
  final Function(String?) onSelected;
  final String? selectedStatus;

  late ZTextField field = ZTextField(
      hint: "Статус",
      focusNode: _focusNode,
  );

  final List<MapEntry<String?, String>> status = [
    MapEntry(null, "Все"),
    MapEntry("ACTIVE", "Активные"),
    MapEntry("PROCESS", "В обработке"),
    MapEntry("BLOCKED", "Заблокированые")
  ];

  final FocusNode _focusNode = FocusNode();

  bool _isOpenList = false;

  _UserStatusSelectWidget({required this.onSelected, this.selectedStatus});

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isOpenList = _focusNode.hasFocus;
      });
    });

    String? statusName;

    status.forEach((element) {
      if (element.key == selectedStatus)
        statusName = element.value;
    });

    field.setText(statusName ?? "");
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      field,
      _isOpenList ? _listData() : Container()
    ],
  );

  _listData() => Container(
    decoration: BoxDecoration(
      border: Border.all(color: primaryColor, width: 2),
      borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8)
      )
    ),
    child: ListView.builder(
        shrinkWrap: true,
        itemCount: status.length,
        itemBuilder: (context, index) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                this._focusNode.unfocus();
                this.field.setText(status[index].value);
                this.onSelected(status[index].key);
                // this._focusNode.
              },
              child: ListTile(
                  title: Text(status[index].value)
              ),
            ),
          );
        }
    ),
  );
}