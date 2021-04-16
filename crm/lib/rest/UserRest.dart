import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/TokenModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class UserRest extends ZakazioRest {
  Future<DataResponse<TokenMode>> login(
      {required String email, required String password}) async {
    final json =
        await post("/user/login", {}, {"email": email, "password": password});

    return DataResponse<TokenMode>.fromJson(
        json, (json) => TokenMode.fromJson(json));
  }

  Future<DataResponse<TokenMode>> registerStep1(
      String email, RoleType roleType) async {
    String urlRole = "executor";

    switch (roleType) {
      case RoleType.CLIENT:
        urlRole = "client";
        break;
      case RoleType.PARTNER:
        urlRole = "partner";
        break;
      case RoleType.EXECUTOR:
        urlRole = "executor";
        break;
      case RoleType.EDITOR:
        break;
      case RoleType.ADMIN:
        break;
      case RoleType.SUPER_ADMIN:
        break;
    }

    final json = await post(
        "/$urlRole/register/step/1", {}, {"email": email});

    return DataResponse<TokenMode>.fromJson(
        json, (json) => TokenMode.fromJson(json));
  }

  Future<DataResponse<TokenMode>> registerStep2(String code, String token, RoleType roleType) async {
    String urlRole = "executor";

    switch (roleType) {
      case RoleType.CLIENT:
        urlRole = "client";
        break;
      case RoleType.PARTNER:
        urlRole = "partner";
        break;
      case RoleType.EXECUTOR:
        urlRole = "executor";
        break;
      case RoleType.EDITOR:
        // TODO: Handle this case.
        break;
      case RoleType.ADMIN:
        // TODO: Handle this case.
        break;
      case RoleType.SUPER_ADMIN:
        // TODO: Handle this case.
        break;
    }

    final json = await post("/$urlRole/register/step/2", {},
        {"code": code, "token": token});

    return DataResponse<TokenMode>.fromJson(
        json, (json) => TokenMode.fromJson(json));
  }

  Future<DataResponse<TokenMode>> registerStep3(
      String token,
      String firstName,
      String lastName,
      String middleName,
      String phoneNumber,
      String password,
      RoleType roleType) async {
    String urlRole = "executor";

    switch (roleType) {
      case RoleType.CLIENT:
        urlRole = "client";
        break;
      case RoleType.PARTNER:
        urlRole = "partner";
        break;
      case RoleType.EXECUTOR:
        urlRole = "executor";
        break;
      case RoleType.EDITOR:
        // TODO: Handle this case.
        break;
      case RoleType.ADMIN:
        // TODO: Handle this case.
        break;
      case RoleType.SUPER_ADMIN:
        // TODO: Handle this case.
        break;
    }

    final json = await post("/$urlRole/register/step/3", {
      "token": token
    }, {
      "firstName": firstName,
      "lastName": lastName,
      "middleName": middleName,
      "phoneNumber": phoneNumber,
      "password": password
    });

    try {
      return DataResponse<TokenMode>.fromJson(
          json, (json) => TokenMode.fromJson(json));
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<Map<String, dynamic>> myData() async {
    final json = await get("/user/", {}, {});

    return json;
  }

  Future<DataResponse<Null>> editUser(
      {required int userID,
      String? firstName,
      String? lastName,
      String? middleName,
      String? email,
      String? phoneNumber,
      int? cityID,
      String? avatarBase64}) async {
    final json = await put("/user/$userID/update", {}, {
      "firstName": firstName,
      "lastName": lastName,
      "middleName": middleName,
      "email": email,
      "cityID": cityID,
      "avatar": avatarBase64,
      "phoneNumber": phoneNumber
    });

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> changeUserPassword(
      {required int userID, required String newPasspord}) async {
    final json = await put("/user/$userID/change/password", {},
        {"newPassword": newPasspord, "oldPassword": null});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<Map<String, dynamic>> userInfo(int userID) async {
    final json = await get("/user/$userID", {}, {});

    return json["data"];
  }

  Future<DataResponse<Null>> blockUser(
      {required int userID}) async {
    final json = await put("/user/$userID/block", {}, {});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }
}
