import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/rest/BaseUserTypeRest.dart';

class ExecutorRest extends BaseUserTypeRest {
  final route = "/executor/";

  @override
  Future<DataResponse<Null>> add(
      String firstName,
      String lastName,
      String middleName,
      String email,
      String password,
      String phoneNumber) async {
    final json = await post(route + "add", {}, {
      "firstName": firstName,
      "lastName": lastName,
      "middleName": middleName,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber
    });

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  @override
  Future<DataResponse<PagedListModel<ExecutorModel>>> list(
      String quary, int pageNum, int size) async {
    final json = await get(route + "list", {},
        {"size": size.toString(), "page": pageNum.toString(), "search": quary});

    try {
      return DataResponse.fromJson(
          json,
          (pageJson) => PagedListModel.fromJson(
              pageJson, (adminJson) => ExecutorModel.fromJson(adminJson)));
    } catch (e) {
      return DataResponse(success: true, data: null);
    }
  }

  @override
  Future<DataResponse<PagedListModel<ExecutorModel>>> listFull(
      String quary, int pageNum, int cityID, int regionID, String? status) async {
    final json = await get(route + "list", {},
        {
          "size": '10',
          "page": pageNum.toString(),
          "search": quary,
          "status": status ?? "",
          "city_id": cityID.toString(),
          "region_id": regionID.toString(),
        });

    try {
      return DataResponse.fromJson(
          json,
              (pageJson) => PagedListModel.fromJson(
              pageJson, (adminJson) => ExecutorModel.fromJson(adminJson)));
    } catch (e) {
      return DataResponse(success: true, data: null);
    }
  }

  @override
  Future<DataResponse<PagedListModel<ExecutorModel>>> listOfOwner(
      int ownerID,
      String quary,
      int pageNum,
      int size) async {
    final json = await get(route + "list/partner/$ownerID", {},
        {"size": size.toString(), "page": pageNum.toString(), "search": quary});

    try {
      return DataResponse.fromJson(
          json,
              (pageJson) => PagedListModel.fromJson(
              pageJson, (adminJson) => ExecutorModel.fromJson(adminJson)));
    } catch (e) {
      return DataResponse(success: true, data: null);
    }
  }
}
