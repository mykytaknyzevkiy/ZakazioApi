import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/app/AppModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/AddRest.dart';
import 'package:zakazy_crm_v2/rest/OrderRest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class AppInfoViewModel extends ZakazyViewModel {
  final _appRepository = AppRest();

  final _orderRest = OrderRest();

  final info = BehaviorSubject<AppModel>.seeded(null);

  final orderList = BehaviorSubject<PagedListModel<OrderModel>>.seeded(null);

  load(int appID) async {
    info.add(null);
    final data = await _appRepository.info(appID);
    info.add(data.data);
  }

  delete(int appID) async {
    info.add(null);
    await _appRepository.remove(appID);
    load(appID);
  }

  loadOrders(int appID, int pageNum) async {
    orderList.add(null);
    final data = await _orderRest.appOrders(pageNum, appID);
    orderList.add(data.data);
  }

  @override
  close() {
    info.close();
    orderList.close();
  }
}
