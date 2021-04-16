// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/pasport/PasportModel.dart';
import 'package:zakazy_crm_v2/repository/PasportRepository.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class PasportRequestViewModel extends ZakazyViewModel {

  final _pasportRepository = PasportRepository();

  final list = BehaviorSubject<List<PasportModel>>.seeded(null);

  final onViewInfo = BehaviorSubject<PasportModel>.seeded(null);

  final onExtrLoading = BehaviorSubject<bool>.seeded(false);

  updateList() async {
    list.add(null);
    list.add(await _pasportRepository.requestList());
  }

  accept(int id) async {
    onExtrLoading.add(true);
    await _pasportRepository.accept(id);
    onViewInfo.add(null);
    updateList();
    onExtrLoading.add(false);
  }

  refuse(int id) async {
    onExtrLoading.add(true);
    await _pasportRepository.refuse(id);
    onViewInfo.add(null);
    updateList();
    onExtrLoading.add(false);
  }

  close() {
    list.close();
    onViewInfo.close();
    onExtrLoading.close();
  }
}
