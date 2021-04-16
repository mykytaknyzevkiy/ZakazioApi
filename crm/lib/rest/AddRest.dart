import 'package:zakazy_crm_v2/model/app/AppModel.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class AppRest extends ZakazioRest {
  final route = "/app";

  Future<DataResponse<Null?>> add(String name, String key) async {
    final data = await post("$route/add", {}, {"name": name, "key": key});

    return DataResponse.fromJson(data, (_) => null);
  }

  Future<DataResponse<AppModel>> info(int id) async {
    final data = await get("$route/$id", {}, {});

    return DataResponse.fromJson(data, (objJson) => AppModel.fromJson(objJson));
  }

  Future<DataResponse<PagedListModel<AppModel>>> list(
      int pageNum, int size) async {
    final data = await get("$route/list", {},
        {"size": size.toString(), "page": pageNum.toString()});

    return DataResponse.fromJson(
        data,
        (jsonD) => PagedListModel.fromJson(
            jsonD, (model) => AppModel.fromJson(model)));
  }

  Future<DataResponse<Null?>> edit(int id, String name, String key) async {
    final data =
        await post("$route/$id/update", {}, {"name": name, "key": key});

    return DataResponse.fromJson(data, (_) => null);
  }

  remove(int id) async {
    final json = await delete("$route/$id/delete", {});
  }
}
