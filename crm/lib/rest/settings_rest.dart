import 'package:zakazy_crm_v2/model/settings/SettingsContactsModel.dart';
import 'package:zakazy_crm_v2/model/settings/notification_enable_settings.dart';
import 'package:zakazy_crm_v2/model/settings/primary_settings.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class SettingsRest extends ZakazioRest {
  final route = "/settings";

  Future<DataResponse<SettingsContactsModel>> contacts() async {
    final json = await get("$route/contacts", {}, {});

    return DataResponse.fromJson(
        json, (dataJson) => SettingsContactsModel.fromJson(dataJson));
  }

  editContacts(SettingsContactsModel set) async {
    final json = await put("$route/contacts", {}, set.toJson());
  }

  Future<DataResponse<PrimarySettings>> primary() async {
    final json = await get("$route/primary", {}, {});

    return DataResponse.fromJson(
        json, (dataJson) => PrimarySettings.fromJson(dataJson));
  }

  editPrimary(PrimarySettings set) async {
    final json = await put("$route/primary", {}, set.toJson());
  }

  Future<DataResponse<NotificationEnableSettings>> notificationEnables(
      bool isEmail) async {
    final path = isEmail ? "email" : "phone";
    final json = await get("$route/notification/$path/enables", {}, {});

    return DataResponse.fromJson(
        json, (dataJson) => NotificationEnableSettings.fromJson(dataJson));
  }

  editNotificationEnables(bool isEmail, NotificationEnableSettings body) async {
    final path = isEmail ? "email" : "phone";
    final json =
        await put("$route/notification/$path/enables", {}, body.toJson());
  }
}
