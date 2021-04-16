import 'package:zakazy_crm_v2/model/help/help_request_model.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class HelpRest extends ZakazioRest {
  final route = "/help";

  Future<DataResponse<Null?>> add(String message, List<String> files) async {
    final json =
        await post("$route/add", {}, {"message": message, "files": files});

    return DataResponse.fromJson(json, (_) => null);
  }

  Future<DataResponse<PagedListModel<HelpRequestModel>>> list(
      int pageIdx) async {
    final json = await get("$route/list", {}, {"page": pageIdx.toString()});

    return DataResponse.fromJson(
        json,
        (dataJson) => PagedListModel.fromJson(
            dataJson, (elementJson) => HelpRequestModel.fromJson(elementJson)));
  }

  Future<DataResponse<HelpRequestModel>> info(int id) async {
    final json = await get("$route/$id", {}, {});

    return DataResponse.fromJson(
        json, (dataJson) => HelpRequestModel.fromJson(dataJson));
  }

  process(int id) async {
    final json = await put("$route/$id/process", {}, {});
    return DataResponse.fromJson(json, (_) => null);
  }

  close(int id) async {
    final json = await put("$route/$id/close", {}, {});
    return DataResponse.fromJson(json, (_) => null);
  }
}
