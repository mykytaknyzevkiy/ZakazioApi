import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class ImportRest extends ZakazioRest {
  Future<DataResponse<String>> importOrders(String fileName) async {
    final json = await post("/order/import/$fileName", {}, {});

    try {
      return DataResponse.fromJsonSingle(json);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> importUsers(
      String fileName, RoleType roleType) async {
    String route = "";

    if (roleType == RoleType.CLIENT) {
      route = "client";
    } else if (roleType == RoleType.EXECUTOR) {
      route = "executor";
    } else if (roleType == RoleType.PARTNER) {
      route = "partner";
    }

    final json = await post("/$route/import/$fileName", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> importCategories(String fileName) async {
    final json = await post("/category/import/$fileName", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> importAddress(String fileName) async {
    final json = await post("/region/import/$fileName", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }
}
