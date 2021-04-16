// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/app/AppModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/AddRest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class AppListViewModel extends ZakazyViewModel {
  final appRest = AppRest();

  final list = BehaviorSubject<PagedListModel<AppModel>>.seeded(null);

  final isExLoading = BehaviorSubject<bool>.seeded(false);

  final isToAddApp = BehaviorSubject<bool>.seeded(false);

  load(int pageNum) async {
    list.add(null);
    final data = await appRest.list(pageNum, 20);
    if (data.success) {
      list.add(data.data);
    } else {
      list.add(PagedListModel(List.empty(), 0));
    }
  }

  add(String name) async {
    isExLoading.add(true);
    await appRest.add(name, "");
    load(0);
    isExLoading.add(false);
  }

  @override
  close() {
    list.close();
    isExLoading.close();
    isToAddApp.close();
  }
}