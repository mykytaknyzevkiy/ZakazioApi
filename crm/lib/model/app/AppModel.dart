import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/UserOrderInfo.dart';
import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';
import 'package:zakazy_crm_v2/model/user/partner/PartnerModel.dart';

class AppModel {
  final int id;
  final String name;
  final String key;
  final UserInfoModel? owner;
  final UserOrderInfoModel order;

  AppModel({
    required this.id,
    required this.name,
    required this.key,
    required this.owner,
    required this.order});

  static AppModel fromJson(Map<String, dynamic> json) => AppModel(
    id: json["id"],
    name: json["name"],
    key: json["key"],
    owner: (json["owner"] != null) ? AdminModel.fromJson(json["owner"]) : null,
    order: (json["order"] != null)
      ? UserOrderInfoModel.fromJson(json["order"])
      : UserOrderInfoModel.empty()
  );


}