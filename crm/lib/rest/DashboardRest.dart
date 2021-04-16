import 'package:zakazy_crm_v2/model/dashboard/DashboardModel.dart';
import 'package:zakazy_crm_v2/model/dashboard/ExecutorDashModel.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class DashboardRest extends ZakazioRest {
  Future<DataResponse<DashboardModel>> system(
      String startDate, String endDate) async {
    final json = await get("/dashboard/system", {},
        {"start_date": startDate, "end_date": endDate});

    return DataResponse.fromJson(
        json, (dataJson) => DashboardModel.fromJson(dataJson));
  }

  Future<DataResponse<List<ExecutorDashModel>>> executors(
      String startDate, String endDate) async {
    final json = await get("/dashboard/executors", {},
        {"start_date": startDate, "end_date": endDate});

    final data = await DataResponse.fromJsonAsList(
        json,
        (jsonData) =>
            jsonData.map((e) => ExecutorDashModel.fromJson(e)).toList());

    return data;
  }
}
