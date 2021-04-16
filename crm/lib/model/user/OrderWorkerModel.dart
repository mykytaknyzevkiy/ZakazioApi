import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/pasport/PasportModel.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/UserOrderInfo.dart';

abstract class OrderWorkerModel extends UserInfoModel {
  final UserOrderInfoModel order;
  final double balance;

  OrderWorkerModel(
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
      PasportModel? pasport,
      this.order,
      this.balance) :
        super(
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

}