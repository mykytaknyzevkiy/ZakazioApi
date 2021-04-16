import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/pasport/PasportModel.dart';
import 'package:zakazy_crm_v2/model/user/OrderWorkerModel.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/UserOrderInfo.dart';

class ExecutorModel extends OrderWorkerModel {
  final double rate;

  final int portfolioCount;

  ExecutorModel(
      {required int id,
      required String? phoneNumber,
      required String? email,
      required String firstName,
      required String lastName,
      required String middleName,
      required bool phoneActive,
      required bool emailActive,
      required bool passportActive,
      required String? avatar,
      required CityModel? city,
      required String role,
      required String? status,
      required this.rate,
      required this.portfolioCount,
      required bool passportInProgress,
      required PasportModel? pasport,
      required UserOrderInfoModel order,
      required double balance})
      : super(
            id,
            phoneNumber ?? "Нет доступа",
            email ?? "Нет доступа",
            firstName,
            lastName,
            middleName,
            phoneActive,
            emailActive,
            passportActive,
            avatar,
            city,
            role,
            status,
            passportInProgress,
            pasport,
            order,
            balance);

  static ExecutorModel fromJson(Map<String, dynamic> json) => ExecutorModel(
      id: json["id"],
      phoneNumber: json["phoneNumber"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      middleName: json["middleName"],
      phoneActive: json["phoneActive"],
      emailActive: json["emailActive"],
      passportActive: json["passportActive"],
      avatar: json["avatar"],
      city: json["city"] != null ? CityModel.fromJson(json["city"]) : null,
      role: json["role"],
      status: json["status"],
      order: UserOrderInfoModel.fromJson(json["order"]),
      rate: json["rate"],
      portfolioCount: json["portfolioCount"],
      passportInProgress: json["passportInProgress"],
      pasport: json["passport"] != null
          ? PasportModel.fromJson(json["passport"])
          : null,
      balance: json["balance"]);
}
