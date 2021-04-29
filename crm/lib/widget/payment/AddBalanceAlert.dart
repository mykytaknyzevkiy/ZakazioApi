import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/payment/BankCardModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/repository/PaymentRepository.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/widget/payment/BankCardViewHolder.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';
import '../../conts.dart';

class AddBalanceAlert extends StatefulWidget {
  final UserProfileViewModel viewModel;
  bool? isOut = false;

  AddBalanceAlert(this.viewModel, {this.isOut});

  @override
  State<StatefulWidget> createState() => _AddBalanceAlert(viewModel);
}

class _AddBalanceAlert extends State<AddBalanceAlert> {
  final UserProfileViewModel viewModel;

  late _SelectBankCardWidget _selectBankCardWidget = _SelectBankCardWidget(
    onSelect: (card) => (widget.isOut == true)
        ? _amountTextFiled.text().isNumeric() && _selectBankCardWidget.selectedCard() != null && (double.parse(_amountTextFiled.text()) <= userBalance)
        : _amountTextFiled.text().isNumeric() && _selectBankCardWidget.selectedCard() != null,
  );

  late ZTextField _amountTextFiled = ZTextField(
    hint: "Сумма в руб.",
    keyBoardType: TextInputType.number,
    inputFormatters: [
      WhitelistingTextInputFormatter.digitsOnly
    ],
    onEdit: (txt) => _nextBtn.setEnable(
        (widget.isOut == true)
            ? txt.isNumeric() && _selectBankCardWidget.selectedCard() != null && (double.parse(txt) <= userBalance)
            : txt.isNumeric() && _selectBankCardWidget.selectedCard() != null
    ),
  );

  late MyButton _nextBtn = MyButton(
    title: (widget.isOut ?? false) ? "Вывести" : "Оплатить",
    onPressed: () => onPay(),
    isEnable: false,
  );

  double userBalance = 0;

  _AddBalanceAlert(this.viewModel);

  load() async {
    userBalance = await viewModel.balance();
  }

  @override
  Widget build(BuildContext context) => Card(
    elevation: 12,
    child: SizedBox(
      //width: 300,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, bottom: 48, top: 48),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text((widget.isOut ?? false) ? "Вывести на карту" : "Пополнить баланс",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Divider(
                color: Colors.transparent,
                height: 30,
              ),
              Text("Выберите карту"),
              Divider(
                height: 15,
                color: Colors.transparent,
              ),
              _selectBankCardWidget,
              Divider(
                  height: 15,
                  color: Colors.transparent
              ),
              SmallButton(
                  title: "Добавить карту",
                  onPressed: () => ZakazioNavigator.pushWParams("user/profile/my/bank/list", {"userID": viewModel.userInfo.value!.id}),
                  isEnable: true),
              Divider(
                  height: 15,
                  color: Colors.transparent
              ),
              _amountTextFiled,
              Divider(
                height: 30,
                color: Colors.transparent,
              ),
              SizedBox(
                  width: 300,
                  child: StreamBuilder(
                    stream: viewModel.isToEditDataLoading,
                    builder: (context, snapShot) {
                      if (snapShot.hasData && snapShot.requireData == true) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _nextBtn,
                            FreeButton(
                              title: "Отменить",
                              onPressed: () => viewModel.toEditData.add(null),
                              isEnable: true,
                            )
                          ],
                        );
                      }
                    },
                  ))
            ],
          )
        )
      ),
    ),
  );

  onPay() async {
    final amount = double.parse(_amountTextFiled.text());
    final card = _selectBankCardWidget.selectedCard()!;

    if (amount <= 0) {
      _amountTextFiled.setError("");
      return;
    }

    viewModel.addBalance(
        context,
        amount.toInt(),
        card.id
    );

  }

}

class _SelectBankCardWidget extends StatelessWidget {
  final Function(BankCardModel) onSelect;
  final _selectedBankCard = BehaviorSubject<BankCardModel>();

  final _paymentRepository = PaymentRepository();

  _SelectBankCardWidget({Key? key, required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder<PagedListModel<BankCardModel>>(
    future: _paymentRepository.userBankCards(UserRepository.instance().myUserLiveData.value!.id),
    builder: (context, snapShot) {
      if (!snapShot.hasData)
        return Center(
          child: CircularProgressIndicator()
        );
      final list = snapShot.requireData.content!;
      return _data(list);
    }
  );

  _data(List<BankCardModel> list) => StreamBuilder<BankCardModel>(
    stream: _selectedBankCard,
    builder: (context, snapShot) {
      final selectedCard = snapShot.data;
      return ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (_, index) => Stack(
            alignment: Alignment.center,
            children: [
              BankCardViewHolder(item: list[index]),
              GestureDetector(
                onTap: () {
                  _selectedBankCard.add(list[index]);
                  onSelect.call(list[index]);
                },
                child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.black)
                    ),
                    child: selectedCard?.id == list[index].id
                        ? Center(
                      child: Icon(
                        Icons.done,
                        size: 25,
                        color: primaryColor,
                      ),
                    )
                        : Container()
                ),
              )
            ],
          )
      );
    }
  );

  _close() {
    _selectedBankCard.close();
  }

  BankCardModel? selectedCard() => _selectedBankCard.value;

}