// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/repository/AddressResponse.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class CityViewModel extends ZakazyViewModel {
  final addressResponse = AddressResponse();

  BehaviorSubject<List<CityModel>> cities =
      BehaviorSubject.seeded(List.empty());

  BehaviorSubject<CityModel?> hasAddEdit = BehaviorSubject.seeded(null);

  load(int regionID) async {
    final list = await addressResponse.cities(regionID);

    cities.add(list);
  }

  add(int regionID, String name, int code) async {
    final data = await addressResponse.addCity(
        regionID, CityModel(-10, name, code, null));

    if (data) {
      hasAddEdit.add(null);
      load(regionID);
    }

    return data;
  }

  edit(int cityID, int regionID, String name, int code) async {
    final data = await addressResponse.editCity(
        cityID, regionID, CityModel(-10, name, code, null));

    if (data) {
      hasAddEdit.add(null);
      load(regionID);
    }

    return data;
  }

  close() {
    cities.close();
    hasAddEdit.close();
  }
}
