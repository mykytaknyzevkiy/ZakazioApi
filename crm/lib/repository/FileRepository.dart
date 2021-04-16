import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
import 'package:zakazy_crm_v2/rest/FileRest.dart';

final _fileRest = FileRest();

class FileRepository {
  Future<String?> uploadFile(PlatformFile file) async {
    final data =
        await _fileRest.uploadFile(base64.encode(file.bytes), file.extension);

    return data.data;
  }
}
