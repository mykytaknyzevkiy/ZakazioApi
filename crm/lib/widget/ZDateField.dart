import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class ZDateField extends StatelessWidget {
  final String hint;

  final BehaviorSubject<int> _reBuild = BehaviorSubject.seeded(0);

  final _txtController = TextEditingController();

  String? _error;

  DateTime? newDate;

  ZDateField({required this.hint}) {
    _txtController.addListener(() {
      _error = null;
      _reBuild.add(7);
    });
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: _reBuild,
      builder: (context, snapShot) {
        return GestureDetector(
            onTap: () => {showDateNPicker(context)},
            child: TextFormField(
              controller: _txtController,
              decoration: InputDecoration(
                  labelText: hint,
                  hintText: "dd/mm/yyyy",
                  border: OutlineInputBorder(),
                  enabled: false,
                  errorText: _error),
            ));
      });

  showDateNPicker(BuildContext context) async {
    newDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2015, 11, 17),
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(2027, 7),
      helpText: 'Выберите дату',
    );

    _reBuild.add(5);

    _txtController.text = dateTxt() ?? "";
  }

  String? dateTxt() {
    if (newDate == null) return null;
    final DateFormat formatter = DateFormat('MM/dd/yyyy');

    return formatter.format(newDate!);
  }

  setError(String error) {
    _error = error;
    _reBuild.add(6);
  }

  close() {
    _reBuild.close();
  }
}
