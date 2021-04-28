// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/history/history_order.dart';
import 'package:zakazy_crm_v2/model/order/OrderCommentModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderStatus.dart';
import 'package:zakazy_crm_v2/model/transaction/TransactionModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/repository/FileRepository.dart';
import 'package:zakazy_crm_v2/repository/OrderRepository.dart';
import 'package:zakazy_crm_v2/repository/PaymentRepository.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/rest/FeedbackRest.dart';
import 'package:zakazy_crm_v2/rest/JurnalRest.dart';
import 'package:zakazy_crm_v2/rest/PaymentRest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';
import 'package:zakazy_crm_v2/unit/FileSelect.dart';
import 'package:zakazy_crm_v2/widget/HelpMessageBubleWidget.dart';

class OrderInfoViewModel extends ZakazyViewModel {
  final _orderRepository = OrderRepository();

  final _fileRepository = FileRepository();

  final _paymentRepository = PaymentRepository();

  final _feedbackRest = FeedbackRest();

  final _paymentRest = PaymentRest();

  final _orderHistoryRest = JurnalRest();

  final BehaviorSubject<OrderModel?> orderData = BehaviorSubject.seeded(null);

  final BehaviorSubject<OrderInfoRightDialogType> rightDialog =
      BehaviorSubject.seeded(null);

  final BehaviorSubject<bool> exLoading = BehaviorSubject.seeded(false);

  final comments = BehaviorSubject<PagedListModel<OrderCommentModel>>.seeded(
      PagedListModel(List.empty(), 0));

  final onDefuseExecutor = BehaviorSubject<bool>.seeded(false);

  final onStartWork = BehaviorSubject<bool>.seeded(false);

  final onDoneWork = BehaviorSubject<bool>.seeded(false);

  final transactions = BehaviorSubject<PagedListModel<TransactionModelImp>>();

  final historyList = BehaviorSubject<PagedListModel<OrderHistory>>();

  loadHistory(int pageIndex) async {
    historyList.add(null);

    final data =
        await _orderHistoryRest.historyOfOrder(orderData.value!.id, pageIndex);

    if (data.success) {
      historyList.add(data.data!);
    } else {
      historyList.add(PagedListModel(List.empty(), 0));
    }
  }

  loadTransactions(int pageIndex) async {
    transactions.add(null);

    final data = await _paymentRest.orderList(orderData.value!.id, pageIndex);

    if (data.success) {
      transactions.add(data.data!);
    } else {
      transactions.add(PagedListModel(List.empty(), 0));
    }
  }

  onEdit() {
    rightDialog.add(OrderInfoRightDialogType.EDIT);
  }

  onSelectExecutor() {
    rightDialog.add(OrderInfoRightDialogType.SELECT_EXECUTOR);
  }

  onFeedback() {
    rightDialog.add(OrderInfoRightDialogType.FEEDBACK);
  }

  sendFeedback(String comment, int rate) async {
    final orderID = orderData.value!.id;

    exLoading.add(true);

    await _feedbackRest.add(orderID, rate, comment);

    exLoading.add(false);

    rightDialog.add(null);

    loadData(orderID);
  }

  loadData(int orderID) async {
    helpMessageData.add(null);
    orderData.add(null);

    final data = await _orderRepository.orderInfo(orderID);

    await UserRepository.instance().initUser();

    orderData.add(data.data);

    final myUser = UserRepository.instance().myUserLiveData.value!;

    if (myUser.roleInfo() == RoleType.EXECUTOR && data.data!.executor == null) {
      helpMessageData.add(
          HelpMessageBubble(
              "После того, как вы станете исполнителем у вас откроется доступ к контактам."
                  "\nНе стоит брать заказ из любопытства и если он вам не подходит,"
                  "у вас в сутки на начальном этапе всего 4 заказа."
                  "\nДальше этот порог будет увеличен."
                  "\nВнимательно прочтите пожелания заказчика в описании.",
              null
          )
      );
    }
    else if (myUser.roleInfo() == RoleType.EXECUTOR
        && data.data!.executor?.id == myUser.id
        && data.data!.statusInfo() == OrderStatus.PROCESS) {
      helpMessageData.add(
          HelpMessageBubble(
              "Рекомендации:\n" +
                  "1. Поздоровайтесь и представьтесь\n" +
                  "2. Уточните потребность\n" +
          "3. Продемонстрируйте экспертность\n" +
          "4. Отправьте ваше портфолио\n" +
          "5. Задайте наводящие вопросы\n" +
              "6. Попросите прислать ТЗ или эскиз\n" +
          "7. Если не прислали ТЗ, напомните\n" +
          "8. Уточняйте у клиента дату начала\n" +
          "9. Выставьте предварительную сумму\n" +
          "10. Дайте взвесить, наберите через 2 часа\n" +
          "11. Не ваш заказ? опишите в комментарии",
              null
          )
      );
    }

    loadTransactions(0);
    loadHistory(0);
  }

  edit(String title, String content, double price, String dateLine) async {
    if (orderData.value == null) return;
    exLoading.add(true);

    final order = orderData.value!;
    final orderID = order.id;
    final files = order.files;

    final data = await _orderRepository.editOrder(
        orderID, title, content, price, dateLine, files);

    exLoading.add(false);

    if (data) {
      loadData(orderData.value!.id);
      rightDialog.add(null);
    }
  }

  removeFile(String fileName) {
    if (orderData.value == null) return;
    final order = orderData.value!;

    final newFiles = List<String>.of({});
    newFiles.addAll(order.files);
    newFiles.remove(fileName);

    order.files = newFiles;

    orderData.add(order);
  }

  addFile() async {
    final file = await FileSelect.selectFile();

    if (file == null) return;

    exLoading.add(true);

    final uploadFile = await _fileRepository.uploadFile(file);

    if (uploadFile != null) {
      _addFile(uploadFile);
    }

    exLoading.add(false);
  }

  _addFile(String fileName) {
    if (orderData.value == null) return;
    final order = orderData.value!;

    final newFiles = List<String>.of({});
    newFiles.addAll(order.files);
    newFiles.add(fileName);

    order.files = newFiles;

    orderData.add(order);
  }

  setExecutor(ExecutorModel executor) async {
    if (!orderData.hasValue) {
      return;
    }

    final orderID = orderData.value!.id;

    exLoading.add(true);

    final data = await _orderRepository.setExecutor(orderID, executor.id);

    exLoading.add(false);

    if (data) {
      loadData(orderID);
      rightDialog.add(null);
    }
  }

  cancelExecutor() async {
    if (!orderData.hasValue) {
      return;
    }

    final orderID = orderData.value!.id;

    exLoading.add(true);

    final data = await _orderRepository.cancelExecutor(orderID);

    exLoading.add(false);

    if (data) {
      loadData(orderID);
      rightDialog.add(null);
    }
  }

  addComment(String comment) async {
    if (!orderData.hasValue) {
      return;
    }

    final orderID = orderData.value!.id;

    exLoading.add(true);

    final data = await _orderRepository.addComment(orderID, comment);

    exLoading.add(false);

    if (data) {
      loadComments(0);
    }
  }

  loadComments(int pageNum) async {
    if (!orderData.hasValue) {
      return;
    }

    final orderID = orderData.value!.id;

    final data = await _orderRepository.commentList(orderID, pageNum, 5);

    comments.add(data);
  }

  cancelOrder() async {
    if (!orderData.hasValue) {
      return;
    }

    final orderID = orderData.value!.id;

    exLoading.add(true);

    orderData.add(null);

    final data = await _orderRepository
        .getOrderRest()
        .setStatus(orderID, OrderStatus.CANCEL);

    exLoading.add(false);

    if (data.success) {
      loadData(orderID);
    }
  }

  doneOrder() async {
    if (!orderData.hasValue) {
      return;
    }

    final orderID = orderData.value!.id;

    exLoading.add(true);

    orderData.add(null);

    final data = await _orderRepository
        .getOrderRest()
        .setStatus(orderID, OrderStatus.DONE);

    exLoading.add(false);

    if (data.success) {
      loadData(orderID);
    }
  }

  beExecutor() async {
    if (!orderData.hasValue) {
      return;
    }

    final orderID = orderData.value!.id;

    exLoading.add(true);

    orderData.add(null);

    final data = await _orderRepository.getOrderRest().beExecutor(orderID);

    exLoading.add(false);

    if (data.success) {
      loadData(orderID);
    }
  }

  defuseExecutorFull(String comment) async {
    if (!orderData.hasValue) {
      return;
    }

    final orderID = orderData.value!.id;

    onDefuseExecutor.add(false);

    exLoading.add(true);

    orderData.add(null);

    final dataCom = await _orderRepository.addComment(orderID, comment);

    final data = await _orderRepository.getOrderRest().cancelExecutor(orderID);

    exLoading.add(false);

    if (data.success) {
      loadData(orderID);
    }
  }

  defuseExecutor() async {
    if (!orderData.hasValue) {
      return;
    }

    final orderID = orderData.value!.id;

    onDefuseExecutor.add(false);

    exLoading.add(true);

    orderData.add(null);

    final data = await _orderRepository.getOrderRest().cancelExecutor(orderID);

    exLoading.add(false);

    if (data.success) {
      loadData(orderID);
    }
  }

  startWork() async {
    if (!orderData.hasValue) {
      return;
    }

    final orderID = orderData.value!.id;

    onDefuseExecutor.add(false);

    exLoading.add(true);

    orderData.add(null);

    final data = await _orderRepository
        .getOrderRest()
        .setStatus(orderID, OrderStatus.IN_WORK);

    exLoading.add(false);

    if (data.success) {
      loadData(orderID);
    }
  }

  Future<double> myBalance() async {
    final userID = UserRepository.instance().myUserLiveData.value!.id;

    return await _paymentRepository.userBalance(userID);
  }

  shareSum() async {
    if (!orderData.hasValue) {
      return;
    }

    final orderID = orderData.value!.id;

    onDefuseExecutor.add(false);

    exLoading.add(true);

    final data =
        await _orderRepository.getOrderRest().shareSum(orderID, orderData.value!.toShareSum);

    exLoading.add(false);

    rightDialog.add(null);

    if (data.success) {
      loadData(orderID);
    }
  }

  close() {
    orderData.close();
    rightDialog.close();
    exLoading.close();
    comments.close();
    onDefuseExecutor.close();
    onStartWork.close();
    onDoneWork.close();
    transactions.close();
    historyList.close();
  }
}

enum OrderInfoRightDialogType { EDIT, SELECT_EXECUTOR, SHARE_SUM, FEEDBACK }
