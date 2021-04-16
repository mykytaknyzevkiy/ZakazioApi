import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/editor/EditorModel.dart';
import 'package:zakazy_crm_v2/rest/BaseUserTypeRest.dart';

class EditorRest extends BaseUserTypeRest {
  final route = "/editor/";

  @override
  Future<DataResponse<Null>> add(
      String firstName,
      String lastName,
      String middleName,
      String email,
      String password,
      String phoneNumber) async {
    final json = await post(route + "add", {}, {
      "firstName": firstName,
      "lastName": lastName,
      "middleName": middleName,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber
    });

    try {
      return DataResponse.fromJson(json, (_) => null);
    } catch (e) {
      return DataResponse(success: false);
    }
  }

  @override
  Future<DataResponse<PagedListModel<EditorModel>>> list(
      String quary, int pageNum, int size) async {
    final json = await get(route + "list", {},
        {"size": size.toString(), "page": pageNum.toString(), "search": quary});

    try {
      return DataResponse.fromJson(
          json,
          (pageJson) => PagedListModel.fromJson(
              pageJson, (adminJson) => EditorModel.fromJson(adminJson)));
    } catch (e) {
      return DataResponse(success: true, data: null);
    }
  }
}
