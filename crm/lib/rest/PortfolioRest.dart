import 'package:zakazy_crm_v2/model/PortfolioModel.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class PortfolioRest extends ZakazioRest {
  Future<DataResponse<Null>> add(String label, String description,
      String wallpaper, List<String> images) async {
    final json = await post("/portfolio/add", {}, {
      "wallpaper": wallpaper,
      "label": label,
      "description": description,
      "imageSlides": images
    });

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<PagedListModel<PortfolioModel>>> list(
      int executorID) async {
    final json = await get("/portfolio/list/user/$executorID", {}, {});
    try {
      return DataResponse<PagedListModel<PortfolioModel>>.fromJson(
          json,
          (jsonN) => PagedListModel<PortfolioModel>.fromJson(
              jsonN, (jsonM) => PortfolioModel.fromJson(jsonM)));
    } catch (e) {
      return DataResponse(success: false, data: null);
    }
  }

  Future<DataResponse<PortfolioModel>> info(int id) async {
    final json = await get("/portfolio/$id/info", {}, {});

    return DataResponse.fromJson(json,
            (dataJson) => PortfolioModel.fromJson(dataJson));
  }

  Future<DataResponse<Null>> edit(int id, String label, String description,
      String? wallpaper, List<String> images) async {
    final json = await put("/portfolio/$id/update", {}, {
      "wallpaper": wallpaper,
      "label": label,
      "description": description,
      "imageSlides": images
    });

    return DataResponse.fromJson(json,
            (_) => null);
  }

  Future<DataResponse<Null>> remove(int id) async {
    final json = await delete("/portfolio/$id/delete", {});

    return DataResponse.fromJson(json,
            (_) => null);
  }
}
