import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/address/RegionModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/AddressRest.dart';

class AddressResponse {
  final addressRest = AddressRest();

  Future<PagedListModel<RegionModel>> regions(int pageIndex) async {
    final data = await addressRest.regions(pageIndex);

    if (data.success && data.data != null) {
      return data.data!;
    } else {
      return PagedListModel(List.empty(), 0);
    }
  }

  Future<bool> createRegion(RegionModel regionModel) async {
    final data =
        await addressRest.addRegion(regionModel.name, regionModel.code);

    return data.success;
  }

  Future<bool> editRegion(RegionModel regionModel) async {
    final data = await addressRest.editRegion(
        regionModel.id, regionModel.name, regionModel.code);

    return data.success;
  }

  Future<List<CityModel>> cities(int regionID) async {
    final data = await addressRest.cities(regionID, 0);

    if (data.success && data.data != null) {
      return data.data!.content!;
    }

    return List.empty();
  }

  Future<bool> addCity(int regionID, CityModel cityModel) async {
    final data =
        await addressRest.addCity(regionID, cityModel.name, cityModel.code);

    return data.success;
  }

  Future<bool> editCity(int cityID, int regionID, CityModel cityModel) async {
    final data = await addressRest.editCity(
        cityID, regionID, cityModel.name, cityModel.code);

    return data.success;
  }

  Future<List<CityModel>> citySearch(String query) async {
    final data = await addressRest.citySearch(query);

    if (data.success && data.data != null) {
      return data.data!.content!;
    }

    return List.empty();
  }
}
