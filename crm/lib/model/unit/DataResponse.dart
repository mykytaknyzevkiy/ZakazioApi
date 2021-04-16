import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';

class DataResponse<T> {
  bool success = false;
  T? data;

  DataResponse({required this.success, this.data});

  DataResponse.fromJson(
      Map<String, dynamic> json, T dataEnc(Map<String, dynamic> json))
      : success = json["success"],
        data = (json["success"] == true) ? dataEnc(json["data"]) : null;

  DataResponse.fromJsonSingle(Map<String, dynamic> json)
      : success = json["success"],
        data = (json["success"] == true) ? json["data"] : null;

  DataResponse.fromJsonDynamic(
      Map<String, dynamic> json, T dataEnc(Map<String, dynamic> json))
      : success = json["success"],
        data = json["data"] != null ? dataEnc(json["data"]) : null;

  DataResponse.fromJsonAsList(
      Map<String, dynamic> json, T dataEnc(List<dynamic> json))
      : success = json["success"],
        data = json["data"] != null ? dataEnc(json["data"]) : null;
}
