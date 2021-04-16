import 'package:intl/intl.dart';
import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';

class OrderHistory {
  final AdminModel user;
  final String data;
  final String creationDate;

  OrderHistory.fromJson(Map<String, dynamic> json)
      : user = AdminModel.fromJson(json["user"]),
        data = json["data"],
        creationDate = json["creationDateTime"];

  String dateStr() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    return formatter.format(DateTime.parse(creationDate));
  }
}
