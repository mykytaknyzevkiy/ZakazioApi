// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/address/RegionModel.dart';
import 'package:zakazy_crm_v2/model/user/partner/PartnerModel.dart';
import 'package:zakazy_crm_v2/rest/partner/PartnerRest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class PartnerViewModel extends ZakazyViewModel {
  final BehaviorSubject<bool> hasToCreateNew = BehaviorSubject.seeded(false);

  final BehaviorSubject<List<PartnerModel>> list =
      BehaviorSubject.seeded(List.empty());

  final BehaviorSubject<int> pageCount = BehaviorSubject.seeded(0);

  final rest = PartnerRest();

  load(String quary, int pageNum, int size, RegionModel? region, CityModel? city, String? status) async {
    final data = await rest.listFull(quary, pageNum, size, region?.id??-1, city?.id??-1, status);

    if (data.success && data.data != null) {
      pageCount.add(data.data!.totalPages);

      list.add(data.data!.content);
    }
  }

  close() {
    hasToCreateNew.close();
    list.close();
    pageCount.close();
  }
}
