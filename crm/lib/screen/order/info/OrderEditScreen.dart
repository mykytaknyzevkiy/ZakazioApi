import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderInfoViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/widget/order/OrderFileViewHolder.dart';

// ignore: must_be_immutable
class OrderEditScreen extends StatelessWidget {
  late OrderInfoViewModel _viewModel = ViewModelProvider<OrderInfoViewModel>().build(() => OrderInfoViewModel());

  late ZTextField _title;

  late ZTextField _content;

  late ZTextField _dateLine;

  late ZTextField _price;

  OrderEditScreen() {
    if (!_viewModel.orderData.hasValue)
      return;

    final order = _viewModel.orderData.value!;

    _title = ZTextField(hint: "Название", txt: order.title);

    _content = ZTextField(hint: "Описание", isMultiline: true, txt: order.content);

    _dateLine = ZTextField(hint: "Предполагаемая дата завершения", txt: order.dateLine);

    _price = ZTextField(hint: "Стоимость в руб.", txt: order.price.toString());
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Card(
          elevation: 12,
          child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24, bottom: 48, top: 48),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Изменить заказ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Divider(
                    color: Colors.transparent,
                    height: 40,
                  ),
                  _title,
                  Divider(
                    color: Colors.transparent,
                    height: 30,
                  ),
                  _content,
                  Divider(
                    color: Colors.transparent,
                    height: 30,
                  ),
                  _dateLine,
                  Divider(
                    color: Colors.transparent,
                    height: 30,
                  ),
                  _price,
                  Divider(
                    color: Colors.transparent,
                    height: 30,
                  ),
                  Text(
                    "Файлы",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  StreamBuilder<OrderModel?>(
                      stream: _viewModel.orderData,
                      builder: (context, snapShot) {
                        if (!snapShot.hasData) return Container();
                        final order = snapShot.requireData!;

                        return Wrap(
                            runSpacing: 20,
                            spacing: 20,
                            children: List.generate(
                                order.files.length,
                                (index) => OrderFileViewHolde(
                                    onDeleteViaName: (fileName) {
                                      _viewModel.removeFile(fileName);
                                    },
                                    fileName: order.files[index])));
                      }),
                  Divider(
                    color: Colors.transparent,
                    height: 20,
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
        ),
      );

  _onSaveClick() {
    bool isOK = true;

    if (_title.text().isEmpty) {
      isOK = false;
      _title.setError("Заполните поле");
    }

    if (_content.text().isEmpty) {
      isOK = false;
      _content.setError("Заполните поле");
    }

    if (_price.text().isEmpty || !_price.text().isNumeric()) {
      isOK = false;
      _price.setError("Укажите сумму");
    }

    if (_dateLine.text().isEmpty) {
      isOK = false;
      _dateLine.setError("Заполните поле");
    }

    if (isOK) {
      _viewModel.edit(_title.text(), _content.text(),
          double.parse(_price.text()), _dateLine.text());
    }
  }

  _onCancelCLick() {
    _viewModel.rightDialog.add(null);
  }

  _btnColum() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FreeButton(
            title: "Добавить файл",
            onPressed: () => {_viewModel.addFile()},
            isEnable: true,
          ),
          Divider(
            color: Colors.transparent,
            height: 30,
          ),
          SizedBox(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyButton(
                  title: "Сохранить",
                  onPressed: () => _onSaveClick(),
                  isEnable: true,
                ),
                FreeButton(
                  title: "Отменить",
                  onPressed: () => _onCancelCLick(),
                  isEnable: true,
                )
              ],
            ),
          )
        ],
      );
}
