import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/client/ClientModel.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/model/user/partner/PartnerModel.dart';

class UserFactor {
  UserInfoModel build(Map<String, dynamic> json) {
    final role = json["role"];
    if (role == "EXECUTOR")
      return ExecutorModel.fromJson(json);
    else if (role == "CLIENT")
      return ClientModel.fromJson(json);
    else if (role == "PARTNER")
      return PartnerModel.fromJson(json);
    else
      return AdminModel.fromJson(json);
  }
}
