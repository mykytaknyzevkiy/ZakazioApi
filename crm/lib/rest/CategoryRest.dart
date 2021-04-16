import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/model/category/ChildCategoryModel.dart';
import 'package:zakazy_crm_v2/model/category/GlobalCategory.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class CategoryRest extends ZakazioRest {
  Future<DataResponse<dynamic>> create(
      String name, bool isActive, String? image64) async {
    final json = await post("/category/add", {},
        {"name": name, "isActive": isActive, "image": image64});

    return DataResponse.fromJson(json, (json) => null);
  }

  Future<DataResponse<PagedListModel<CategoryModel>>> list(int pageNum) async {
    final json = await get("/category/list", {}, {"page": pageNum.toString()});

    return DataResponse.fromJson(
        json,
        (jsonN) => PagedListModel.fromJson(
            jsonN, (jsonM) => CategoryModel.fromJson(jsonM)));
  }

  Future<DataResponse<PagedListModel<CategoryModel>>> listActive(
      int pageNum) async {
    final json =
        await get("/category/list/active", {}, {"page": pageNum.toString()});

    return DataResponse.fromJson(
        json,
        (jsonN) => PagedListModel.fromJson(
            jsonN, (jsonM) => CategoryModel.fromJson(jsonM)));
  }

  Future<DataResponse<PagedListModel<CategoryModel>>> searchListActive(
      int pageNum, String query) async {
    final json = await get("/category/list/active/search", {},
        {"page": pageNum.toString(), "query": query});

    return DataResponse.fromJson(
        json,
        (jsonN) => PagedListModel.fromJson(
            jsonN, (jsonM) => CategoryModel.fromJson(jsonM)));
  }

  Future<DataResponse<Null>> editCategory(
      int id, String name, bool isActive, String? image64) async {
    final json = await put("/category/$id/update", {},
        {"name": name, "isActive": isActive, "image": image64});

    return DataResponse.fromJson(json, (json) => null);
  }

  Future<DataResponse<Null>> addChildCategory(int parentID, String name) async {
    final json = await post("/category/$parentID/add", {}, {"name": name});

    return DataResponse.fromJson(json, (json) => null);
  }

  Future<DataResponse<Null>> editChildCategory(
      int parentID, int id, String name) async {
    final json =
        await put("/category/$parentID/$id/update", {}, {"name": name});

    return DataResponse.fromJson(json, (json) => null);
  }

  Future<DataResponse<PagedListModel<ChildCategoryModel>>> childList(
      int parentID, String query, int pageIndex) async {
    final json = await get("/category/$parentID/list", {},
        {"page": pageIndex.toString(), "query": query});

    return DataResponse.fromJson(
        json,
        (jsonN) => PagedListModel.fromJson(
            jsonN, (jsonM) => ChildCategoryModel.fromJson(jsonM)));
  }

  Future<DataResponse<List<GlobalCategory>>> globalSeaarch(String query) async {
    final json = await get("/category/global/search", {}, {"query": query});

    return DataResponse.fromJsonAsList(json,
        (dataJson) => dataJson.map((e) => GlobalCategory.fromJson(e)).toList());
  }
}
