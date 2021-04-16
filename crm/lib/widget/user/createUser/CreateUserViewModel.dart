// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/rest/admin/AdminRest.dart';
import 'package:zakazy_crm_v2/rest/BaseUserTypeRest.dart';
import 'package:zakazy_crm_v2/rest/editor/EditorRest.dart';
import 'package:zakazy_crm_v2/rest/executor/ExecutorRest.dart';
import 'package:zakazy_crm_v2/rest/partner/PartnerRest.dart';
import 'package:zakazy_crm_v2/rest/client/ClientRest.dart';

class CreateUserViewModel {
  final BehaviorSubject<String?> errorTxt = BehaviorSubject.seeded(null);
  final BehaviorSubject<bool> isLoading = BehaviorSubject.seeded(false);

  Future<bool> save(
      RoleType roleType,
      String firstName,
      String lastName,
      String middleName,
      String email,
      String password,
      String phoneNumber) async {
    BaseUserTypeRest? rest;

    errorTxt.add(null);

    isLoading.add(true);

    if (roleType == RoleType.ADMIN) {
      rest = AdminRest();
    } else if (roleType == RoleType.EDITOR) {
      rest = EditorRest();
    } else if (roleType == RoleType.PARTNER) {
      rest = PartnerRest();
    } else if (roleType == RoleType.EXECUTOR) {
      rest = ExecutorRest();
    } else if (roleType == RoleType.CLIENT) {
      rest = ClientRest();
    } else {
      isLoading.add(false);
      return false;
    }

    final data = await rest.add(
        firstName, lastName, middleName, email, password, phoneNumber);

    isLoading.add(false);

    if (!data.success) {
      errorTxt.add("Пользователь с таким номером или email\nуже существует");
    }

    return data.success;
  }

  close() {
    errorTxt.close();
    isLoading.close();
  }
}
