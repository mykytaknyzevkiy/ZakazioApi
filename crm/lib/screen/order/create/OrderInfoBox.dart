// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/order/CreateOrderViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';
import 'package:zakazy_crm_v2/widget/order/OrderFileViewHolder.dart';

// ignore: must_be_immutable
class OrderInfoBox extends StatefulWidget {
  _OrderInfoBoxState? _state;

  @override
  State<StatefulWidget> createState() {
    _state = _OrderInfoBoxState();

    return _state!;
  }

  bool check() {
    if (_state == null) return false;
    return _state!.check();
  }

  title() => _state?.title();

  content() => _state?.content();

  dateLine() => _state?.dateLine();

  price() => _state?.price();
}

class _OrderInfoBoxState extends State<OrderInfoBox> {
  final _viewModel = ViewModelProvider<CreateOrderViewModel>().build(() => CreateOrderViewModel());

  final _title = ZTextField(hint: "Название", maxLength: 50);

  final _content = ZTextField(hint: "Описание", isMultiline: true, maxLength: 255,);

  final _dateLine = ZTextField(hint: "Предпологаемая дата завершения", maxLength: 25);

  final _price = ZTextField(hint: "Стомиость в руб.");

  @override
  Widget build(BuildContext context) => Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Информация заказа",
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              height: 30,
              color: Colors.transparent,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: _title,
            ),
            Divider(
              height: 20,
              color: Colors.transparent,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: _content,
            ),
            Divider(
              height: 20,
              color: Colors.transparent,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: _dateLine,
            ),
            Divider(
              height: 20,
              color: Colors.transparent,
            ),
            SizedBox(
              width: 200,
              child: _price,
            ),
            Divider(
              height: 30,
            ),
            Text(
              "Файли",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            Divider(
              height: 20,
              color: Colors.transparent,
            ),
            StreamBuilder<List<PlatformFile>>(
                stream: _viewModel.selectedFiles,
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
                                onDelete: (file) =>
                                    {_viewModel.removeFile(file)})));
                  }
                  return Text("Нету файлов");
                }),
            Divider(
              height: 20,
              color: Colors.transparent,
            ),
            FreeButton(
                title: "Добавить",
                onPressed: () => {_viewModel.addFile()},
                isEnable: true)
          ]),
        ),
      );

  title() => _title.text();

  content() => _content.text();

  dateLine() => _dateLine.text();

  price() => double.tryParse(_price.text());

  bool check() {
    bool isOK = true;

    if (_title.text().isEmpty) {
      isOK = false;
      setState(() {
        _title.setError("Заполните поле");
      });
    }

    if (_content.text().isEmpty) {
      isOK = false;
      setState(() {
        _content.setError("Заполните поле");
      });
    }

    if (_price.text().isEmpty || !_price.text().isNumeric()) {
      isOK = false;
      setState(() {
        _price.setError("Укажите сумму");
      });
    }

    if (_dateLine.text().isEmpty) {
      isOK = false;
      setState(() {
        _dateLine.setError("Заполните поле");
      });
    }

    return isOK;
  }
}
