import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/user/TokenModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class ActiveUserData extends ZakazioRest {
  Future<DataResponse<TokenMode>> sendSmsPhone() async {
    final json = await put("/user/active/phone", {}, {});

    try {
      return DataResponse.fromJson(json, (data) => TokenMode.fromJson(data));
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> checkSmsPhone(String token, String code) async {
    final json =
        await put("/user/active/phone", {}, {"smsCode": code, "token": token});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<TokenMode>> sendEmail() async {
    final json = await put("/user/active/email", {}, {});

    try {
      return DataResponse.fromJson(json, (data) => TokenMode.fromJson(data));
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  Future<DataResponse<Null>> checkEmail(String token, String code) async {
    final json =
        await put("/user/active/email", {}, {"code": code, "token": token});

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }
}
