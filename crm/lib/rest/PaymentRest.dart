import 'package:zakazy_crm_v2/model/payment/BankCardModel.dart';
import 'package:zakazy_crm_v2/model/payment/CloudPayment3dsModel.dart';
import 'package:zakazy_crm_v2/model/transaction/TransactionModel.dart';
import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class PaymentRest extends ZakazioRest {
  final route = "/payment";

  Future<DataResponse<double>> userBalance(int userID) async {
    final json = await get("$route/$userID/balance", {}, {});

    try {
      return DataResponse.fromJsonSingle(json);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<CloudPayment3dsModel?>> addBalance(int userID, int sum, int bankCardID) async {
    final json = await post(
        "$route/$userID/add/pay", {}, {
          "bankCardID": bankCardID,
          "amount": sum
        });

    try {
      return DataResponse.fromJsonDynamic(
          json,
              (dataJson) => CloudPayment3dsModel.fromJson(dataJson));
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<PagedListModel<BankCardModel>>> userBankCards(
      int userID) async {
    final json = await get("$route/$userID/card/list", {}, {});

    try {
      return DataResponse.fromJson(
          json,
          (dataJson) => PagedListModel.fromJson(
              dataJson, (modelJson) => BankCardModel.fromJson(modelJson)));
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null?>> addBankCard(
      String num,
      String expMonth,
      String expYear,
      String crypto) async {
    final json = await post(
        "$route/add/card", {}, {
        "num": num,
        "expMonth": expMonth,
        "expYear": expYear,
        "crypto": crypto
    });

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }
  
  Future<DataResponse<PagedListModel<TransactionModelImp>>> userList(int userID, int pageIndex) async {
    final json = await get("/transaction/user/$userID/list", {}, {
      "page": pageIndex.toString(),
      "size": "10"
    });

    try {
      return DataResponse.fromJson(
          json,
              (dataJson) => PagedListModel.fromJson(
                  dataJson,
                      (elementJson) => TransactionModelImp.fromJson(elementJson))
      );
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<PagedListModel<TransactionModelImp>>> orderList(int orderID, int pageIndex) async {
    final json = await get("/transaction/order/$orderID/list", {}, {
      "page": pageIndex.toString(),
      "size": "10"
    });

    try {
      return DataResponse.fromJson(
          json,
              (dataJson) => PagedListModel.fromJson(
              dataJson,
                  (elementJson) => TransactionModelImp.fromJson(elementJson))
      );
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null?>> outSum(int bankCardID, double amount) async {
    final json = await post("$route/out/sum", {}, {
      "bankCardID": bankCardID.toString(),
      "amount": amount.toString()
    });

    try {
      return DataResponse.fromJson(
          json,
              (_) => null
      );
    } catch (e) {
      return DataResponse(success: false);
    }
  }
}
