import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class ZTextField extends StatelessWidget {
  final String hint;
  String? txt;
  final bool? isMultiline;

  final int? maxLength;

  String? _error;
  bool _isEnable = true;

  final txtController = TextEditingController();

  final BehaviorSubject<int> _reBuild = BehaviorSubject.seeded(0);

  Function(String text)? onEdit;

  final FocusNode? focusNode;

  final TextInputType? keyBoardType;

  final List<TextInputFormatter>? inputFormatters;

  ZTextField(
      {
        required this.hint,
        this.txt,
        this.isMultiline,
        this.onEdit,
        this.maxLength,
        this.focusNode,
        this.keyBoardType,
        this.inputFormatters
      }) {
    txtController.addListener(() {
      if (_error != null) {
        _error = null;
        _reBuild.add(_reBuild.value! + 1);
      }
      txt = text();
      onEdit?.call(text());
    });
    if (txt != null) {
      txtController.text = txt!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _field();
  }

  _field() => StreamBuilder(
        stream: _reBuild,
        builder: (_, snapshot) {
          return TextFormField(
              autofocus: false,
              inputFormatters: inputFormatters,
              focusNode: this.focusNode,
              maxLength: maxLength,
              minLines: (isMultiline == true) ? 7 : null,
              keyboardType:
                  (isMultiline == true) ? TextInputType.multiline : keyBoardType,
              maxLines: (isMultiline == true) ? null : 1,
              controller: txtController,
              decoration: InputDecoration(
                  labelText: hint,
                  border: OutlineInputBorder(),
                  enabled: _isEnable,
                  errorText: _error));
        },
      );

  String text() => txtController.text;

  setText(String txt) {
    txtController.text = txt;
    _reBuild.add(_reBuild.value! + 1);
  }

  setError(String? nError) {
    this._error = nError;
    _reBuild.add(_reBuild.value! + 1);
  }

  setEnable(bool isEnable) {
    this._isEnable = isEnable;
    _reBuild.add(_reBuild.value! + 1);
  }

  close() {
    _reBuild.close();
  }
}
