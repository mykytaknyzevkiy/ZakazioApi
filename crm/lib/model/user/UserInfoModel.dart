import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/pasport/PasportModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

abstract class UserInfoModel {
  final int id;
  final String phoneNumber;
  final String email;
  final String firstName;
  final String lastName;
  final String middleName;
  final bool phoneActive;
  final bool emailActive;
  final bool passportActive;
  final String? avatar;
  final CityModel? city;
  final String role;
  final String? status;
  final bool passportInProgress;
  final PasportModel? pasport;

  UserInfoModel(
      this.id,
      this.phoneNumber,
      this.email,
      this.firstName,
      this.lastName,
      this.middleName,
      this.phoneActive,
      this.emailActive,
      this.passportActive,
      this.avatar,
      this.city,
      this.role,
      this.status,
      this.passportInProgress,
      this.pasport);

  RoleType roleInfo() => findRoleType(role);

  bool isActive() => status == "ACTIVE";

  bool isBlocked() => status == "BLOCKED";

  String statusTxt() {
    if (status == "ACTIVE")
      return "Активен";
    else if (status == "BLOCKED")
      return "Заблокирован";
    else if (status == "PROCESS")
      return "В обработке";
    else
      return "";
  }

  bool canBeEdit() {
    if (!UserRepository.instance().myUserLiveData.hasValue) return false;
    final myUser = UserRepository.instance().myUserLiveData.value!;

    if (myUser.id == this.id)
      return true;
    else if (myUser.roleInfo() == RoleType.SUPER_ADMIN)
      return true;
    else if (myUser.roleInfo() == RoleType.ADMIN &&
        this.roleInfo() != RoleType.SUPER_ADMIN &&
        this.roleInfo() != RoleType.ADMIN)
      return true;
    else if (myUser.roleInfo() == RoleType.EDITOR &&
        this.roleInfo() != RoleType.SUPER_ADMIN &&
        this.roleInfo() != RoleType.ADMIN &&
        this.roleInfo() != RoleType.EDITOR)
      return true;
    else
      return false;
  }

  bool canBlock() {
    if (!UserRepository.instance().myUserLiveData.hasValue) return false;
    final myUser = UserRepository.instance().myUserLiveData.value!;

    if (roleInfo() == RoleType.SUPER_ADMIN)
      return false;
    else if (myUser.roleInfo() == RoleType.SUPER_ADMIN)
      return true;
    else if (myUser.roleInfo() == RoleType.ADMIN &&
        this.roleInfo() != RoleType.SUPER_ADMIN &&
        this.roleInfo() != RoleType.ADMIN)
      return true;
    else if (myUser.roleInfo() == RoleType.EDITOR &&
        this.roleInfo() != RoleType.SUPER_ADMIN &&
        this.roleInfo() != RoleType.ADMIN &&
        this.roleInfo() != RoleType.EDITOR)
      return true;
    else
      return false;
  }
}
