import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';

class BankCardModel {
  final int id;
  final UserInfoModel user;
  final String endNum;
  final String exp;

  BankCardModel(
      {required this.id,
      required this.user,
      required this.endNum,
      required this.exp});

  BankCardModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        user = AdminModel.fromJson(json["user"]),
        endNum = json["endNum"],
        exp = json["exp"];
}
