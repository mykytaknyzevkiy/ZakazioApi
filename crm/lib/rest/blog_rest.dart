import 'package:zakazy_crm_v2/model/blog/blog_model.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class BlogRest extends ZakazioRest {
  final route = "/blog";

  Future<DataResponse<PagedListModel<BlogModel>>> list(int pageIdx) async {
    final json = await get("$route/list", {}, {"page": pageIdx.toString()});

    return DataResponse.fromJson(
        json,
        (dataJson) => PagedListModel.fromJson(
            dataJson, (elementJson) => BlogModel.fromJson(elementJson)));
  }

  Future<DataResponse<BlogModel>> info(int id) async {
    final json = await get("$route/$id", {}, {});

    return DataResponse.fromJson(
        json, (dataEnc) => BlogModel.fromJson(dataEnc));
  }

  add(String title, String content, String wallpaper64) async {
    final json = await post("$route/add", {},
        {"title": title, "content": content, "wallpaper64": wallpaper64});

    return DataResponse.fromJson(json, (_) => null);
  }

  edit(int id, String? title, String? content, String? wallpaper64) async {
    final json = await put("$route/$id", {},
        {"title": title, "content": content, "wallpaper64": wallpaper64});

    return DataResponse.fromJson(json, (_) => null);
  }

  remove(int id) async {
    final json = await delete("$route/$id", {});

    return DataResponse.fromJson(json, (_) => null);
  }
}
