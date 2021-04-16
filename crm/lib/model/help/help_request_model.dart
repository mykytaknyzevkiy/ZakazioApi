import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';

class HelpRequestModel {
  final int id;
  final AdminModel user;
  final String message;
  final List<String> files;
  final String status;
  final String creationDateTime;

  HelpRequestModel(this.id, this.user, this.message, this.files, this.status,
      this.creationDateTime);

  HelpRequestModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        user = AdminModel.fromJson(json["user"]),
        message = json["message"],
        files = (json["files"] as List).map((e) => e.toString()).toList(),
        status = json["status"],
        creationDateTime = json["creationDateTime"];

  String dateStr() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    return formatter.format(DateTime.parse(creationDateTime));
  }

  Color statusColor() {
    if (status == "OPEN")
      return Colors.grey;
    else if (status == "CLOSE")
      return Colors.green;
    else
      return Colors.yellow;
  }

  Widget statusWidget() => Container(
        width: 130,
        height: 30,
        decoration: BoxDecoration(
            color: statusColor(),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Center(
          child: Text(
            status,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}
