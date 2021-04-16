import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/address/RegionModel.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class AddressRest extends ZakazioRest {
  Future<DataResponse<PagedListModel<RegionModel>>> regions(int pageNum) async {
    final json = await get("/region/list", {}, {"page": pageNum.toString()});

    try {
      return DataResponse.fromJson(
          json,
          (jsonN) => PagedListModel.fromJson(
              jsonN, (jsonM) => RegionModel.fromJson(jsonM)));
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<dynamic>> addRegion(String name, int zipCode) async {
    final json =
        await post("/region/add", {}, {"name": name, "postCode": zipCode});

    try {
      return DataResponse.fromJson(json, (jsonN) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<dynamic>> editRegion(
      int id, String name, int zipCode) async {
    final json =
        await put("/region/$id", {}, {"name": name, "postCode": zipCode});

    try {
      return DataResponse.fromJson(json, (jsonN) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<PagedListModel<CityModel>>> cities(
      int regionID, int pageNum) async {
    final json = await get(
        "/region/$regionID/city/list", {}, {"page": pageNum.toString()});

    try {
      return DataResponse.fromJson(
          json,
          (jsonN) => PagedListModel.fromJson(
              jsonN, (jsonM) => CityModel.fromJson(jsonM)));
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<dynamic>> addCity(
      int regionID, String name, int zipCode) async {
    final json = await post(
        "/region/$regionID/city/add", {}, {"name": name, "postCode": zipCode});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<dynamic>> editCity(
      int cityID, int regionID, String name, int zipCode) async {
    final json = await put("/region/$regionID/city/$cityID", {},
        {"name": name, "postCode": zipCode});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<PagedListModel<CityModel>>> citySearch(
      String query) async {
    final json = await get("/region/city/search", {}, {"query": query});

    try {
      return DataResponse.fromJson(
          json,
          (jsonN) => PagedListModel.fromJson(
              jsonN, (jsonM) => CityModel.fromJson(jsonM)));
    } catch (e) {
      return DataResponse(success: false);
    }
  }
}
