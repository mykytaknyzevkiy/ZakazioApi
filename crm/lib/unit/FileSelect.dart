// ignore: avoid_web_libraries_in_flutter
// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker_web/image_picker_web.dart';

class FileSelect {
  static selectImage() async {
    return await ImagePickerWeb.getImage(outputType: ImageType.bytes);
  }

  static Future<PlatformFile?> selectFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    return result.files.single;
  }

  static Future<PlatformFile?> selectImageFile() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    return result.files.single;
  }
}
