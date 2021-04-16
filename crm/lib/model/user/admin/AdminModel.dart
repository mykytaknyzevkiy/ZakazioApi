import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/pasport/PasportModel.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';

class AdminModel extends UserInfoModel {
  AdminModel(
      int id,
      String phoneNumber,
      String email,
      String firstName,
      String lastName,
      String middleName,
      bool phoneActive,
      bool emailActive,
      bool passportActive,
      String? avatar,
      CityModel? city,
      String role,
      String? status,
      bool passportInProgress,
      PasportModel? pasport)
      : super(
            id,
            phoneNumber,
            email,
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
            pasport);

  static AdminModel fromJson(Map<String, dynamic> json) {
    return AdminModel(
        json["id"],
        json["phoneNumber"],
        json["email"],
        json["firstName"],
        json["lastName"],
        json["middleName"],
        json["phoneActive"],
        json["emailActive"],
        json["passportActive"],
        json["avatar"],
        (json["city"] != null) ? CityModel.fromJson(json["city"]) : null,
        json["role"],
        json["status"],
        json["passportInProgress"],
        json["passport"] != null ? PasportModel.fromJson(json["passport"]) : null);
  }
}
