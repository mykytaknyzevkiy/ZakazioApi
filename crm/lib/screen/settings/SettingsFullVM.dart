import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/settings/notification_enable_settings.dart';
import 'package:zakazy_crm_v2/model/settings/primary_settings.dart';
import 'package:zakazy_crm_v2/rest/settings_rest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class SettingsFullViewModel extends ZakazyViewModel {
  final _settingsRest = SettingsRest();

  final primary = BehaviorSubject<PrimarySettings>();
  final notificationEnable = BehaviorSubject<
      MapEntry<NotificationEnableSettings, NotificationEnableSettings>>();

  final onEdit = BehaviorSubject<SettingsEditType>();

  final onExLoading = BehaviorSubject<bool>.seeded(false);

  loadPrimary() async {
    primary.add(null);
    final data = await _settingsRest.primary();
    if (data.success) {
      primary.add(data.data);
    }
  }

  editPrimary(PrimarySettings set) async {
    onExLoading.add(true);
    await _settingsRest.editPrimary(set);
    onEdit.add(null);
    loadPrimary();
    onExLoading.add(false);
  }

  loadNotificationEnable() async {
    final email = (await _settingsRest.notificationEnables(true)).data!;
    final phone = (await _settingsRest.notificationEnables(false)).data!;

    notificationEnable.add(MapEntry(email, phone));
  }

  editNotificationEnable(
      MapEntry<NotificationEnableSettings, NotificationEnableSettings>
          data) async {
            onExLoading.add(true);
    await _settingsRest.editNotificationEnables(true, data.key);
    await _settingsRest.editNotificationEnables(false, data.value);
    onEdit.add(null);
    loadNotificationEnable();
    onExLoading.add(false);
  }

  @override
  close() {
    primary.close();
    onEdit.close();
    onExLoading.close();
    notificationEnable.close();
  }
}

enum SettingsEditType { PRIMARY, NOTIFICATION_ENABLES }
