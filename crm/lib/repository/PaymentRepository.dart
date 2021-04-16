import 'package:zakazy_crm_v2/model/payment/BankCardModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/PaymentRest.dart';

class PaymentRepository {
  final paymentRest = PaymentRest();

  Future<double> userBalance(int userID) async {
    final data = await paymentRest.userBalance(userID);

    if (data.success) {
      return data.data!;
    }

    return 0;
  }

  Future<PagedListModel<BankCardModel>> userBankCards(userID) async {
    final data = await paymentRest.userBankCards(userID);

    if (data.success) {
      return data.data!;
    } else {
      return PagedListModel(List.empty(), 0);
    }
  }

  Future<bool> addBankCard(String num,
      String expMonth,
      String expYear,
      String crypto) async {
    final data = await paymentRest.addBankCard(num, expMonth, expYear, crypto);

    return data.success;
  }

}
