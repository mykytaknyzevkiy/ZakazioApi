import 'package:zakazy_crm_v2/model/order/OrderCommentModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderStatus.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/FeedbackRest.dart';
import 'package:zakazy_crm_v2/rest/OrderRest.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class OrderRepository {
  final OrderRest _orderRest = OrderRest();
  final _feedbackRest = FeedbackRest();

  OrderRest getOrderRest() => _orderRest;

  Future<DataResponse<OrderModel?>> orderInfo(int id) async {
    final data = await _orderRest.orderInfo(id);

    if (data.data != null) {
      data.data!.feedbackAboutClient = (await _feedbackRest.orderAboutClient(id)).data;
      data.data!.feedbackAboutExecutor = (await _feedbackRest.orderAboutExecutor(id)).data;
    }

    return data;
  }

  Future<PagedListModel<OrderModel>> userOrders(
      int userID, int pageNum, String search, int size) async {
    final data = await _orderRest.userOrders(userID, pageNum, size, search);
    if (data.success && data.data != null)
      return data.data!;
    else
      return PagedListModel(List.empty(), 0);
  }

  Future<PagedListModel<OrderModel>> openList(
      int pageNum,
      String search,
      int cityID, 
      int categoryID,
      OrderStatus? orderStatus) async {
    final data = await _orderRest.openOrders(pageNum, search, cityID, categoryID, orderStatus?.toZString());

    if (data.data == null) return PagedListModel(List.empty(), 0);

    if (data.success && data.data != null) {
      if (pageNum > (data.data ?? PagedListModel(List.empty(), 0)).totalPages) {
        return PagedListModel(List.empty(), 0);
      }
      return (data.data ?? PagedListModel(List.empty(), 0));
    } else
      return PagedListModel(List.empty(), 0);
  }

  Future<bool> addOrder(
      {required String title,
      required String content,
      required double price,
      required String dateLine,
      required int cityID,
      required int categoryID,
      int? executorID,
      required String clientFirstName,
      required String clientLastName,
      required String clientMiddleName,
      required String clientPhone,
      required String clientEmail,
      required List<String> fileUrls}) async {
    return (await _orderRest.addOrder(
            title,
            content,
            price,
            dateLine,
            cityID,
            categoryID,
            executorID,
            clientFirstName,
            clientLastName,
            clientMiddleName,
            clientPhone,
            clientEmail,
            fileUrls))
        .success;
  }

  Future<bool> editOrder(int id, String title, String content, double price,
      String dateLine, List<String> files) async {
    return (await _orderRest.editOrder(
            id, title, content, price, dateLine, files))
        .success;
  }

  Future<bool> setExecutor(int id, int executorID) async {
    final data = await _orderRest.setExecutor(id, executorID);

    return data.success;
  }

  Future<bool> cancelExecutor(int id) async {
    final data = await _orderRest.cancelExecutor(id);

    return data.success;
  }

  Future<bool> addComment(int id, String text) async {
    final data = await _orderRest.addComment(id, text);

    return data.success;
  }

  Future<PagedListModel<OrderCommentModel>> commentList(
      int orderID,
      int pageNum,
      int size) async {
    final data = await _orderRest.commentList(orderID, pageNum, size);

    if (data.success && data.data != null) {
      return data.data!;
    }

    return PagedListModel(List.empty(), 0);
  }

}
