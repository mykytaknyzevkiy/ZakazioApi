import 'package:intl/intl.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/model/payment/BankCardModel.dart';
import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';

class TransactionModelImp {
  final int id;
  final double amount;
  final AdminModel user;
  final BankCardModel? card;
  final OrderModel? order;
  final String creationDateTime;
  final String operation;

  TransactionModelImp(
      this.id,
      this.amount,
      this.user,
      this.card,
      this.order,
      this.creationDateTime,
      this.operation
      );

  TransactionModelImp.fromJson(Map<String, dynamic> json) :
      id = json["id"],
      amount = json["amount"],
      user = AdminModel.fromJson(json["user"]),
      order = (json["order"] != null)
          ? OrderModel.fromJson(json["order"])
          : null,
      creationDateTime = json["creationDateTime"],
      operation = json["operation"],
      card = (json["card"] != null)
  ? BankCardModel.fromJson(json["card"])
  : null;

  String dateStr() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    return formatter.format(DateTime.parse(creationDateTime));
  }

}