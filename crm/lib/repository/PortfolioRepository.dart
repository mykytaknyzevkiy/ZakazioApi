// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
import 'package:zakazy_crm_v2/model/PortfolioModel.dart';
import 'package:zakazy_crm_v2/repository/FileRepository.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/rest/PortfolioRest.dart';

class PortfolioRepository {
  final _fileRepository = FileRepository();
  final _portfolioRest = PortfolioRest();
  final _userRepository = UserRepository.instance();

  Future<bool> add(String label, String description, PlatformFile wallpaperFile,
      List<PlatformFile> imageFiles) async {
    final wallpaper = await _fileRepository.uploadFile(wallpaperFile);

    if (wallpaper == null) return false;

    final images = List<String>.of({});

    for (int i = 0; i < imageFiles.length; i++) {
      final link = await _fileRepository.uploadFile(imageFiles[i]);
      if (link != null) {
        images.add(link);
      }
    }

    final data =
        await _portfolioRest.add(label, description, wallpaper, images);

    if (data.success) {
      _userRepository.initUser();
    }

    return data.success;
  }

  Future<List<PortfolioModel>> list(int executorID) async {
    final data = await _portfolioRest.list(executorID);
    if (data.data == null) return List.empty();

    return data.data!.content!;
  }
}
