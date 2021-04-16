// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/repository/FileRepository.dart';
import 'package:zakazy_crm_v2/repository/OrderRepository.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';
import 'package:zakazy_crm_v2/unit/FileSelect.dart';

class CreateOrderViewModel extends ZakazyViewModel {
  final BehaviorSubject<List<PlatformFile>> selectedFiles =
      BehaviorSubject.seeded(List.empty());

  final _orderRepository = OrderRepository();

  final _fileRepository = FileRepository();

  addFile() async {
    final file = await FileSelect.selectFile();

    if (file == null) return;

    final value = selectedFiles.value;

    final newValue = List.generate((value.length + 1),
        (index) => (index >= value.length) ? file : value[index]);

    selectedFiles.add(newValue);
  }

  removeFile(PlatformFile file) async {
    final value = selectedFiles.value;

    value.remove(file);

    selectedFiles.add(value);
  }

  Future<bool> saveOrder(
      {required String title,
      required String content,
      required String dateLine,
      required double price,
      required CityModel city,
      required CategoryModel category,
      required String clientFName,
      required String clientLName,
      required String clientMName,
      required String clientEmail,
      required String clientPhone}) async {
    List<String> files = List.of({});

    for (int i = 0; i < selectedFiles.value.length; i++) {
      final uploadFile =
          await _fileRepository.uploadFile(selectedFiles.value[i]);

      if (uploadFile != null) {
        files.add(uploadFile);
      }
    }

    return false;

    /*return await _orderRepository.addOrder(
        title,
        content,
        price,
        dateLine,
        city.id,
        category.id,
        null,
        clientFName,
        clientLName,
        clientMName,
        clientPhone,
        clientEmail,
        files); */
  }

  close() {
    selectedFiles.close();
  }
}
