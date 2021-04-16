import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_main.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_vm.dart';
import 'package:zakazy_crm_v2/unit/FileSelect.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/widget/order/OrderFileViewHolder.dart';

class FillOrderInfo extends CreateOrderStateScreen {
  final _viewModel = ViewModelProvider<CreateOrderNewViewModel>()
      .build(() => CreateOrderNewViewModel());

  final _title = ZTextField(hint: "Название", maxLength: 50);

  final _content = ZTextField(
    hint: "Описание",
    isMultiline: true,
    maxLength: 255,
  );

  final _selectedFiles =
      BehaviorSubject<List<PlatformFile>>.seeded(List.empty());

  FillOrderInfo(Function() onNext)
      : super(CreateOrderState.INFORMATION, "Описание проекта", onNext) {
    if (_viewModel.orderInfo != null) {
      _title.setText(_viewModel.orderInfo!.title);
      _content.setText(_viewModel.orderInfo!.content);
      _selectedFiles.add(_viewModel.orderInfo!.files);
    }
  }

  @override
  Widget content(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title,
          Divider(
            height: 10,
            color: Colors.transparent,
          ),
          _content,
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          Text("Файлы", style: TextStyle(fontSize: 24)),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          StreamBuilder<List<PlatformFile>>(
              stream: _selectedFiles,
              builder: (context, snapShot) {
                if (snapShot.hasData && snapShot.requireData.isNotEmpty) {
                  final nList = snapShot.requireData;
                  return Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: List.generate(
                          nList.length,
                          (index) => OrderFileViewHolde(
                              file: nList[index],
                              onDelete: (file) {
                                final _files = _selectedFiles.value!;
                                _files.removeAt(index);
                                _selectedFiles.add(_files);
                              })));
                }
                return Text("Нет файлов");
              }),
          Divider(
            height: 10,
            color: Colors.transparent,
          ),
          FreeButton(
              title: "Добавить", onPressed: () => {_addFile()}, isEnable: true)
        ],
      );

  _addFile() async {
    final file = await FileSelect.selectFile();

    if (file == null) return;

    final value = _selectedFiles.value;

    final newValue = List.generate((value.length + 1),
        (index) => (index >= value.length) ? file : value[index]);

    _selectedFiles.add(newValue);
  }

  close() {
    _selectedFiles.close();
  }

  @override
  nextClick() {
    if (_title.text().isEmpty) {
      _title.setError("");
      return;
    }
    if (_content.text().isEmpty) {
      _content.setError("");
      return;
    }

    _viewModel.orderInfo = OrderInfoData(
        title: _title.text(),
        content: _content.text(),
        files: _selectedFiles.value ?? List.empty());

    return super.nextClick();
  }
}
