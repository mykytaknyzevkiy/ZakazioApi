import 'package:zakazy_crm_v2/model/unit/DataResponse.dart';
import 'package:zakazy_crm_v2/rest/ZakazioRest.dart';

class FileRest extends ZakazioRest {
  Future<DataResponse<String?>> uploadFile(String base64, String format) async {
    final json =
        await post("/file/add/byte", {}, {"file": base64, "format": format});

    try {
      return DataResponse.fromJsonSingle(json);
    } catch (e) {
      return DataResponse(success: false);
    }
  }
}
