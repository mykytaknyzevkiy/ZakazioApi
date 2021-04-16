import 'package:zakazy_crm_v2/model/pasport/PasportModel.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class PasportRest extends ZakazioRest {
  Future<DataResponse<Null>> sendPasportInfo(
      String serial,
      String number,
      String dateEx,
      String taxID,
      String firstPage64,
      String secoundPage64,
      String facedPage64) async {
    final json = await post("/passport/request/add", {}, {
      "serial": serial,
      "number": number,
      "date_begin": dateEx,
      "taxID": taxID,
      "files": [firstPage64, secoundPage64, facedPage64]
    });

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<PagedListModel<PasportModel>>> requestList() async {
    final json = await get("/passport/request/list", {}, {});

    try {
      return DataResponse.fromJson(
          json,
          (dataJson) => PagedListModel.fromJson(
              dataJson, (itemJson) => PasportModel.fromJson(itemJson)));
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> accept(int id) async {
    final json = await put("/passport/request/$id/accept", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> refuse(int id) async {
    final json = await put("/passport/request/$id/refuse", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }
}
