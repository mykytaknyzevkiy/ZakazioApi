import 'package:zakazy_crm_v2/model/history/history_order.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class JurnalRest extends ZakazioRest {
  final route = "/history";
  late String orderRoute = "$route/order";

  historyOfOrder(int orderID, int pageNum) async {
    final json = await get(
        "$orderRoute/order/$orderID", {}, {"page": pageNum.toString()});

    return DataResponse.fromJson(
        json,
        (dataJson) => PagedListModel.fromJson(
            dataJson, (eJson) => OrderHistory.fromJson(eJson)));
  }
}
