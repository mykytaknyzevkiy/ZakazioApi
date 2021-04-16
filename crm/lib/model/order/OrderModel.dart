import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/model/feedback/FeedbackModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderStatus.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:zakazy_crm_v2/model/user/client/ClientModel.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class OrderModel {
  final int id;
  final ClientModel client;
  final String status;
  final String title;
  final String content;
  final double price;
  final String dateLine;
  final CityModel city;
  final bool beExecutorEnable;
  final bool cancelExecutorEnable;
  final bool inWorkEnable;
  final bool doneEnable;
  final bool commentEnable;
  final double toShareSum;
  final ExecutorModel? executor;
  final String creationDate;
  List<String> files;
  final bool editEnable;
  final CategoryModel category;
  final bool setExecutorEnable;
  final bool cancelEnable;
  final bool defuseMeExecutorEnable;

  FeedbackModel? feedbackAboutClient;
  FeedbackModel? feedbackAboutExecutor;

  OrderModel(
      this.id,
      this.status,
      this.title,
      this.content,
      this.price,
      this.dateLine,
      this.beExecutorEnable,
      this.cancelExecutorEnable,
      this.inWorkEnable,
      this.doneEnable,
      this.commentEnable,
      this.toShareSum,
      this.client,
      this.city,
      this.executor,
      this.creationDate,
      this.files,
      this.editEnable,
      this.category,
      this.setExecutorEnable,
      this.cancelEnable,
      this.defuseMeExecutorEnable);

  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        status = json["status"],
        title = json["title"],
        content = json["content"],
        price = json["price"],
        dateLine = json["dateLine"],
        beExecutorEnable = json["beExecutorEnable"],
        cancelExecutorEnable = json["cancelExecutorEnable"],
        inWorkEnable = json["inWorkEnable"],
        doneEnable = json["doneEnable"],
        commentEnable = json["commentEnable"],
        toShareSum = json["toShareSum"],
        client = ClientModel.fromJson(json["client"]),
        city = CityModel.fromJson(json["city"]),
        creationDate = json["creationDate"],
        executor = (json["executor"] != null)
            ? ExecutorModel.fromJson(json["executor"])
            : null,
        files = (json["files"] as List).map((e) => e.toString()).toList(),
        editEnable = json["editEnable"],
        category = CategoryModel.fromJson(json["category"]),
        setExecutorEnable = json["setExecutorEnable"],
        cancelEnable = json["cancelEnable"],
        defuseMeExecutorEnable = json["defuseMeExecutorEnable"];

  OrderStatus statusInfo() => findStatus(status);

  String dateStr() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    return formatter.format(DateTime.parse(creationDate));
  }
}
