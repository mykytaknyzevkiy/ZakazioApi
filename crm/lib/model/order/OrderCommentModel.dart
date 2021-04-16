import 'package:intl/intl.dart';
import 'package:zakazy_crm_v2/factor/UserFactor.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';

class OrderCommentModel {
  final int id;
  final UserInfoModel user;
  final String text;
  final String creationDateTime;

  OrderCommentModel({
    required this.id,
    required this.user,
    required this.text,
    required this.creationDateTime});

  static OrderCommentModel fromJson(Map<String, dynamic> json) => OrderCommentModel(
    id: json["id"],
    user: AdminModel.fromJson(json["user"]),
    text: json["text"],
    creationDateTime: json["creationDateTime"]
  );

  String dateStr() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    return formatter.format(DateTime.parse(creationDateTime));
  }

}