import 'package:zakazy_crm_v2/model/app/AppModel.dart';
import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';

class DashboardModel {
  final OrderDash oder;
  final List<KeyValue<String>> user;
  final TransactionDash transaction;

  DashboardModel(
      {required this.oder,
        required this.user,
        required this.transaction
      });

  static DashboardModel fromJson(Map<String, dynamic> json) => DashboardModel(
    oder: OrderDash.fromJson(json["oder"]),
    user: (json["user"] as List).map((e) => KeyValue.fromJson<String>(e)).toList(),
    transaction: TransactionDash.fromJson(json["transaction"])
  );

}

class OrderDash {
  final int total;
  final List<KeyValue<String>> statuses;
  final List<KeyValue<AdminModel>> partners;
  final List<KeyValue<AdminModel>> executors;
  final List<KeyValue<AppModel>> apps;
  final List<KeyValue<String>> dates;

  OrderDash(
      {required this.total,
      required this.statuses,
      required this.partners,
      required this.executors,
      required this.apps,
      required this.dates});

  static OrderDash fromJson(Map<String, dynamic> json) => OrderDash(
      total: json["total"],
      statuses: (json["statuses"] as List).map((e) => KeyValue.fromJson<String>(e)).toList(),
      partners: (json["partners"] as List).map((e) => KeyValue.fromJsonKeyEnc<AdminModel>(e, (keyJson) => AdminModel.fromJson(keyJson))).toList(),
      executors: (json["executors"] as List).map((e) => KeyValue.fromJsonKeyEnc<AdminModel>(e, (keyJson) => AdminModel.fromJson(keyJson))).toList(),
      apps: (json["apps"] as List).map((e) => KeyValue.fromJsonKeyEnc<AppModel>(e, (keyJson) => AppModel.fromJson(keyJson))).toList(),
      dates: (json["dates"] as List).map((e) => KeyValue.fromJson<String>(e)).toList()
  );
}

class TransactionDash {
  final int systemTotalSum;
  final int totalInSum;
  final int totalOutCardSum;
  final int totalPartnerSum;
  final int totalOrderSum;
  final int totalInWaitOrderSum;
  final int totalLostOrderSum;
  final int totalSystemReceiveSum;
  final List<KeyValue<String>> dates;

  TransactionDash({
    required this.systemTotalSum,
    required this.totalInSum,
    required this.totalOutCardSum,
    required this.totalPartnerSum,
    required this.totalOrderSum,
    required this.totalInWaitOrderSum,
    required this.totalLostOrderSum,
    required this.totalSystemReceiveSum,
    required this.dates});

  static TransactionDash fromJson(Map<String, dynamic> json) => TransactionDash(
      systemTotalSum: (json["systemTotalSum"] as double).toInt(),
      totalInSum: (json["totalInSum"] as double).toInt(),
      totalOutCardSum: (json["totalOutCardSum"] as double).toInt(),
      totalPartnerSum: (json["totalPartnerSum"] as double).toInt(),
      totalOrderSum: (json["totalOrderSum"] as double).toInt(),
      totalInWaitOrderSum: (json["totalInWaitOrderSum"] as double).toInt(),
      totalLostOrderSum: (json["totalLostOrderSum"]  as double).toInt(),
      totalSystemReceiveSum: (json["totalSystemReceiveSum"] as double).toInt(),
      dates: (json["dates"] as List).map((e) => KeyValue.fromJson<String>(e)).toList()
  );
}

class KeyValue<KEY> {
  final KEY key;
  final int value;

  KeyValue(
      {required this.key,
       required this.value});

  static KeyValue<KEY> fromJson<KEY>(Map<String, dynamic> json) => KeyValue<KEY>(
    key: json["key"],
    value: (json["value"] as double).toInt()
  );

  static KeyValue<KEY> fromJsonKeyEnc<KEY>(Map<String, dynamic> json, KEY keyEnc(Map<String, dynamic> json)) => KeyValue<KEY>(
      key: keyEnc(json["key"]),
      value: json["value"]
  );
}