import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

abstract class BaseUserTypeRest extends ZakazioRest {
  Future<DataResponse<dynamic>> add(String firstName, String lastName,
      String middleName, String email, String password, String phoneNumber);

  Future<DataResponse<PagedListModel<dynamic>>> list(
      String quary, int pageNum, int size);
}
