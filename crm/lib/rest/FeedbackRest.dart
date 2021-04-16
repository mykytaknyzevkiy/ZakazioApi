import 'package:zakazy_crm_v2/model/feedback/FeedbackModel.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class FeedbackRest extends ZakazioRest {
  final route = "/feedback";

  Future<DataResponse<FeedbackModel>> orderAboutClient(int orderID) async {
    final json = await get('$route/order/$orderID/client', {}, {});

    try {
      return DataResponse.fromJson(json, (dataJson) => FeedbackModel.fromJson(dataJson));
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<FeedbackModel>> orderAboutExecutor(int orderID) async {
    final json = await get('$route/order/$orderID/executor', {}, {});

    try {
      return DataResponse.fromJson(json, (dataJson) => FeedbackModel.fromJson(dataJson));
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null?>> add(int orderID, int stars, String comment) async {
    final json = await post("$route/order/$orderID/add", {}, {
      "stars": stars,
      "text": comment
    });

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<PagedListModel<FeedbackModel>>> user(int userID) async {
    final json = await get('$route/user/$userID', {}, {});

    try {
      return DataResponse.fromJson(
          json,
              (dataJson) => PagedListModel.fromJson(
                  dataJson,
                      (elementJson) => FeedbackModel.fromJson(
                          elementJson
                      )
              )
      );
    } catch (e) {
      return DataResponse(success: false);
    }
  }

}