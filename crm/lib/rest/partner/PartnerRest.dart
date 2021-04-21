import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/partner/PartnerModel.dart';
import 'package:zakazy_crm_v2/rest/BaseUserTypeRest.dart';

class PartnerRest extends BaseUserTypeRest {
  final route = "/partner/";

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

  //@override
  Future<DataResponse<PagedListModel<PartnerModel>>> listFull(
      String quary, int pageNum, int size, int regionID, int cityID, String? status) async {
    final json = await get(route + "list", {},
        {"size": size.toString(), "page": pageNum.toString(), "search": quary, "region_id": regionID.toString(), "city_id": cityID.toString(), "status": status ?? ""});

    try {
      return DataResponse.fromJson(
          json,
          (pageJson) => PagedListModel.fromJson(
              pageJson, (adminJson) => PartnerModel.fromJson(adminJson)));
    } catch (e) {
      return DataResponse(success: true, data: null);
    }
  }

  @override
  Future<DataResponse<PagedListModel<PartnerModel>>> list(String quary, int pageNum, int size) async {
    final json = await get(route + "list", {},
        {"size": size.toString(), "page": pageNum.toString(), "search": quary});

    try {
      return DataResponse.fromJson(
          json,
              (pageJson) => PagedListModel.fromJson(
              pageJson, (adminJson) => PartnerModel.fromJson(adminJson)));
    } catch (e) {
      return DataResponse(success: true, data: null);
    }
  }
}
