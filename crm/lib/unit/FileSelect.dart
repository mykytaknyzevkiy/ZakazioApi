// ignore: avoid_web_libraries_in_flutter
// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:js' as js;


class FileSelect {
  static selectImage() async {
    return await ImagePickerWeb.getImage(outputType: ImageType.bytes);
  }

  static Future<PlatformFile?> selectFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result.files.single != null ) {
      final n = result.files.single.size / 1000 / 1000;
      if (n > 10) {
        js.context.callMethod("alert", [
          "Файл не может быть больше 10 мб"
        ]);
        return null;
      }
    }

    return result.files.single;
  }

  static Future<PlatformFile?> selectImageFile() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result.files.single != null ) {
      final n = result.files.single.size / 1000 / 1000;
      if (n > 10) {
        js.context.callMethod("alert", [
          "Файл не может быть больше 10 мб"
        ]);
        return null;
      }
    }

    return result.files.single;
  }
}
