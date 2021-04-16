// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/address/RegionModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/repository/AddressResponse.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class RegionViewModel extends ZakazyViewModel {
  final _addressResponse = AddressResponse();

  BehaviorSubject<PagedListModel<RegionModel>> regions = BehaviorSubject();

  BehaviorSubject<RegionModel?> hasAddEdit = BehaviorSubject.seeded(null);

  int _lastPageIndex = 0;

  load(int pageIndex) async {
    _lastPageIndex = pageIndex;

    regions.add(null);

    final list = await _addressResponse.regions(pageIndex);

    regions.add(list);
  }

  add(String name, int zipCode) async {
    await _addressResponse.createRegion(RegionModel(-10, name, zipCode));

    load(0);

    hasAddEdit.add(null);
  }

  edit(int id, String name, int zipCode) async {
    await _addressResponse.editRegion(RegionModel(id, name, zipCode));

    load(_lastPageIndex);

    hasAddEdit.add(null);
  }

  close() {
    regions.close();
    hasAddEdit.close();
  }
}
