import 'package:file_picker/file_picker.dart';
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/notificattion_service.dart';
import 'package:zakazy_crm_v2/repository/FileRepository.dart';
import 'package:zakazy_crm_v2/rest/OrderRest.dart';
import 'package:zakazy_crm_v2/rest/import_rest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class ImportViewModel extends ZakazyViewModel {
  final _importRest = ImportRest();
  final _fileRepository = FileRepository();

  final isLoading = BehaviorSubject<MapEntry<bool, String?>>.seeded(MapEntry(false, null));

  importOrder(PlatformFile file) async {
    isLoading.add(MapEntry(true, null));

    final fileName = await _fileRepository.uploadFile(file);

    final data = await _importRest.importOrders(fileName!);

    isLoading.add(MapEntry(true, data.data));

    /*NotoficationService.onMessage.add(
        NotificationMessage("Импортируется заказы", "Идет обработка..."));*/

    //isLoading.add(false);
  }

  importAddress(PlatformFile file) async {
    isLoading.add(MapEntry(true, null));

    final fileName = await _fileRepository.uploadFile(file);

    await _importRest.importAddress(fileName!);

  }

  importCategories(PlatformFile file) async {
    isLoading.add(MapEntry(true, null));

    final fileName = await _fileRepository.uploadFile(file);

    await _importRest.importCategories(fileName!);

  }

  importUser(PlatformFile file, RoleType roleType) async {
    isLoading.add(MapEntry(true, null));

    final fileName = await _fileRepository.uploadFile(file);

    await _importRest.importUsers(fileName!, roleType);
  }

  @override
  close() {
    isLoading.close();
  }
}
