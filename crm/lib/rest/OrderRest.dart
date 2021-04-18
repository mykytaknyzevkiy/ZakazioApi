import 'package:file_picker/file_picker.dart';
import 'package:zakazy_crm_v2/model/order/OrderCommentModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderStatus.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class OrderRest extends ZakazioRest {
  Future<DataResponse<OrderModel?>> orderInfo(int id) async {
    final json = await get("/order/$id/info", {}, {});

    try {
      return DataResponse.fromJson(
          json, (orderJson) => OrderModel.fromJson(orderJson));
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<PagedListModel<OrderModel>>> openOrders(
      int pageNum, String search, int cityID, int categoryID, String? status) async {
    final json = await get("/order/list", {}, {
      "search": search,
      "page": pageNum.toString(),
      "size": "10",
      "city_id": cityID.toString(),
      "category_id": categoryID.toString(),
      "status": status ?? ""
    });

    try {
      final data = DataResponse<PagedListModel<OrderModel>>.fromJson(
          json,
          (jsonN) => PagedListModel<OrderModel>.fromJson(
              jsonN, (jsonM) => OrderModel.fromJson(jsonM)));

      return data;
    } catch (e) {
      return DataResponse(success: false, data: null);
    }
  }

  Future<DataResponse<PagedListModel<OrderModel>>> appOrders(
      int pageNum, int appID) async {
    final json = await get("/order/list/app/$appID", {},
        {"page": pageNum.toString(), "size": "5"});

    try {
      final data = DataResponse<PagedListModel<OrderModel>>.fromJson(
          json,
          (jsonN) => PagedListModel<OrderModel>.fromJson(
              jsonN, (jsonM) => OrderModel.fromJson(jsonM)));

      return data;
    } catch (e) {
      return DataResponse(success: false, data: null);
    }
  }

  Future<DataResponse<PagedListModel<OrderModel>>> userOrders(
      int userID, int pageNum, int size, String search) async {
    final json = await get("/order/list/user/$userID", {}, {
      "search": search,
      "size": size.toString(),
      "page": pageNum.toString()
    });

    try {
      final data = DataResponse<PagedListModel<OrderModel>>.fromJson(
          json,
          (jsonN) => PagedListModel<OrderModel>.fromJson(
              jsonN, (jsonM) => OrderModel.fromJson(jsonM)));

      return data;
    } catch (e) {
      return DataResponse(success: false, data: null);
    }
  }

  Future<DataResponse<Null>> editOrder(int id, String title, String content,
      double price, String dateLine, List<String> files) async {
    final data = await put("/order/$id/edit", {},
        {"title": title, "content": content, "price": price, "files": files, "dateLine": dateLine});

    try {
      return DataResponse.fromJson(data, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<dynamic>> addOrder(
      String title,
      String content,
      double price,
      String dateLine,
      int cityID,
      int categoryID,
      int? executorID,
      String clientFirstName,
      String clientLastName,
      String clientMiddleName,
      String clientPhone,
      String clientEmail,
      List<String> fileUrls) async {
    final json = await post("/order/add", {}, {
      "title": title,
      "content": content,
      "price": price,
      "dateLine": dateLine,
      "cityID": cityID,
      "categoryID": categoryID,
      "executorID": executorID,
      "client_first_name": clientFirstName,
      "client_last_name": clientLastName,
      "client_middle_name": clientMiddleName,
      "client_phone": clientPhone,
      "client_email": clientEmail,
      "files": fileUrls
    });

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> setExecutor(int orderID, int executorID) async {
    final json = await put("/order/$orderID/set/executor/$executorID", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> cancelExecutor(int orderID) async {
    final json = await put("/order/$orderID/cancel/executor", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> addComment(int orderID, String text) async {
    final json = await post("/order/$orderID/comment/add", {}, {"text": text});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<PagedListModel<OrderCommentModel>>> commentList(
      int orderID, int pageNum, int size) async {
    final json = await get("/order/$orderID/comment/list", {},
        {"size": size.toString(), "page": pageNum.toString()});

    try {
      final data = DataResponse<PagedListModel<OrderCommentModel>>.fromJson(
          json,
          (jsonN) => PagedListModel<OrderCommentModel>.fromJson(
              jsonN, (jsonM) => OrderCommentModel.fromJson(jsonM)));

      return data;
    } catch (e) {
      return DataResponse(success: false, data: null);
    }
  }

  Future<DataResponse<Null>> setStatus(int orderID, OrderStatus status) async {
    String statusTxt = "";

    if (status == OrderStatus.CANCEL)
      statusTxt = "cancel";
    else if (status == OrderStatus.IN_WORK)
      statusTxt = "work";
    else if (status == OrderStatus.DONE) statusTxt = "done";

    final json = await put("/order/$orderID/set/status/$statusTxt", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> beExecutor(int orderID) async {
    final json = await put("/order/$orderID/be/executor", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> shareSum(int orderID, double amount) async {
    final json = await put("/order/$orderID/share/sum/$amount", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> importOrders(PlatformFile file) async {
    final json = await post("/order/import", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> importOrdersFileName(String fileName) async {
    final json = await post("/order/import/$fileName", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  /*Future<DataResponse<Null>> removeFile(int orderID, String fileName) async {
    final json =
        await put("/order/$orderID/edit/remove/file/$fileName", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  } */
}
