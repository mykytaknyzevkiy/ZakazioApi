import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/payment/BankCardModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/repository/PaymentRepository.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'dart:js' as js;
import 'package:zakazy_crm_v2/widget/payment/BankCardInput.dart';
import 'package:zakazy_crm_v2/widget/payment/BankCardViewHolder.dart';

class MyBankCardScreen extends StatefulWidget {
  final int userID;

  const MyBankCardScreen({Key? key, required this.userID}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyBankCardScreen(userID);
}

class _MyBankCardScreen
    extends HomeScreen<MyBankCardScreen, _MyBankCardViewModel> {
  final int userID;

  late _MyBankCardViewModel _viewModel = viewModel();

  _MyBankCardScreen(this.userID);

  @override
  void initState() {
    _viewModel.loadCardList(userID);
    super.initState();
  }

  @override
  Widget rightDialog() => StreamBuilder(
      stream: _viewModel.onAddBankCard,
      builder: (context, snapShot) {
        if (snapShot.data == true) return _AddBankCardScreen(userID: userID);
        return Container();
      });

  @override
  Widget body() => StreamBuilder<PagedListModel<BankCardModel>>(
    stream: _viewModel.bankCardList,
    builder: (context, snapShot) {
      if (!snapShot.hasData)
        return Center(
          child: CircularProgressIndicator()
        );
      return Wrap(
        children: List.generate(
            snapShot.requireData.content!.length,
                (index) => BankCardViewHolder(
                    item: snapShot.requireData.content![index])
        ),
      );
    }
  );

  @override
  Widget top() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Мои банковские карты",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
          ),
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          MyButton(
            title: "Добавить карту",
            isEnable: true,
            onPressed: () => _viewModel.addCard(),
          )
        ],
      );

  @override
  _MyBankCardViewModel viewModelInstancer() => _MyBankCardViewModel();
}

class _MyBankCardViewModel extends ZakazyViewModel {
  final onAddBankCard = BehaviorSubject<bool>.seeded(false);
  final isExLoading = BehaviorSubject<bool>.seeded(false);
  final bankCardList =
      BehaviorSubject<PagedListModel<BankCardModel>>.seeded(null);

  final _paymentRepository = PaymentRepository();

  addCard() async {
   final data = await _paymentRepository.paymentRest.addBankCardRequest();
   final url = data.data;

   js.context.callMethod("openInNewTab", [url]);
  }

  saveNewCard(
      {required int userID,
      required String cardNum,
      required String cardExpMonth,
      required String cardExpYear,
      required String cardName,
      required String cardCvv}) async {
    isExLoading.add(true);

    try {
      final cardCrypto = await js.context.callMethod("createCyptograf",
          [cardNum, cardExpMonth, cardExpYear, cardName, cardCvv]);

      if (cardCrypto == null) {
        isExLoading.add(false);
        return;
      }

      final data = await _paymentRepository.addBankCard(cardNum, cardExpMonth, cardExpYear, cardCrypto);

      if (data) {
        onAddBankCard.add(false);
        loadCardList(userID);
      }

      isExLoading.add(false);
    } catch (e) {
      isExLoading.add(false);
    }
  }

  loadCardList(int userID) async {
    bankCardList.add(null);
    final data = await _paymentRepository.userBankCards(userID);
    bankCardList.add(data);
  }

  @override
  close() {
    isExLoading.close();
    onAddBankCard.close();
    bankCardList.close();
  }
}

class _AddBankCardScreen extends StatelessWidget {
  final _viewModel = ViewModelProvider<_MyBankCardViewModel>()
      .build(() => _MyBankCardViewModel());

  final _bankCardInput = BankCardInput();

  final int userID;

  _AddBankCardScreen({Key? key, required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Добавить новую карту",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Divider(height: 40, color: Colors.transparent),
            _bankCardInput,
            Divider(
              height: 25,
              color: Colors.transparent,
            ),
            StreamBuilder(
                stream: _viewModel.isExLoading,
                builder: (context, snapShot) {
                  if (snapShot.data == true)
                    return Center(child: CircularProgressIndicator());
                  return SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyButton(
                          title: "Добавить",
                          onPressed: () => _onSaveClick(),
                          isEnable: true,
                        ),
                        FreeButton(
                          title: "Отменить",
                          onPressed: () => _viewModel.onAddBankCard.add(false),
                          isEnable: true,
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ));

  _onSaveClick() async {
    bool isError = !_bankCardInput.check();

    if (isError) return;

    _viewModel.saveNewCard(
        userID: userID,
        cardName: _bankCardInput.cardName(),
        cardExpMonth: _bankCardInput.cardExpMonth(),
        cardExpYear: _bankCardInput.cardExpYear(),
        cardNum: _bankCardInput.cardNum(),
        cardCvv: _bankCardInput.cardCvv()
    );
  }
}
