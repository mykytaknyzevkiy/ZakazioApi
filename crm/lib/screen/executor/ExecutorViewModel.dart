// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/rest/executor/ExecutorRest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class ExecutorViewModel extends ZakazyViewModel {
  final BehaviorSubject<bool> hasToCreateNew = BehaviorSubject.seeded(false);

  final BehaviorSubject<PagedListModel<ExecutorModel>> list = BehaviorSubject();

  final rest = ExecutorRest();

  load(String quary, int pageNum, String? status, CityModel? city) async {
    list.add(null);

    final data = await rest.listFull(quary, pageNum, city?.id ?? -1, status);

    if (!data.success || data.data == null) {
      list.add(
        PagedListModel(List.empty(), 0)
      );
      return;
    }

    list.add(data.data);
  }

  close() {
    hasToCreateNew.close();
    list.close();
  }
}
