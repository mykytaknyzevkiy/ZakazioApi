import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
import 'package:zakazy_crm_v2/model/pasport/PasportModel.dart';
import 'package:zakazy_crm_v2/rest/PasportRest.dart';

class PasportRepository {
  final _pasportRest = PasportRest();

  Future<bool> sendPasportInfo(String serial, String number, String dateEx,
      String taxID, PlatformFile firstPage, PlatformFile secoundPage, PlatformFile facePage) async {
    final data = await _pasportRest.sendPasportInfo(
        serial,
        number,
        dateEx,
        taxID,
        base64.encode(firstPage.bytes),
        base64.encode(secoundPage.bytes),
        base64.encode(facePage.bytes));

    return data.success;
  }

  Future<List<PasportModel>> requestList() async {
    final data = await _pasportRest.requestList();

    if (data.data != null && data.success) return data.data!.content!;

    return List.empty();
  }

  accept(int id) async {
    return await _pasportRest.accept(id);
  }

  refuse(int id) async {
    return await _pasportRest.refuse(id);
  }
}
