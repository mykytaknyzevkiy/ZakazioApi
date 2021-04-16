import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';

class PasportModel {
  final int id;
  final String serial;
  final String number;
  final String dateBegin;
  final String taxID;
  final List<String> files;
  final UserInfoModel? user;

  PasportModel(
      {required this.id,
      required this.serial,
      required this.number,
      required this.dateBegin,
      required this.taxID,
      required this.files,
      required this.user});

  PasportModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        serial = json["serial"],
        number = json["number"],
        dateBegin = json["date_begin"],
        taxID = json["taxID"],
        files = (json["files"] as List).map((e) => e.toString()).toList(),
        user = json["user"] == null ? null : AdminModel.fromJson(json["user"]);
}
