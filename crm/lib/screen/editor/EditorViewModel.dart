// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/user/editor/EditorModel.dart';
import 'package:zakazy_crm_v2/rest/editor/EditorRest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class EditorViewModel extends ZakazyViewModel {
  final BehaviorSubject<bool> hasToCreateNew = BehaviorSubject.seeded(false);

  final BehaviorSubject<List<EditorModel>> list =
      BehaviorSubject.seeded(List.empty());

  final BehaviorSubject<int> pageCount = BehaviorSubject.seeded(0);

  final rest = EditorRest();

  load(String quary, int pageNum, int size) async {
    final data = await rest.list(quary, pageNum, size);

    if (data.success && data.data != null) {
      pageCount.add(data.data!.totalPages);
      list.add(data.data!.content);
    }
  }

  close() {
    hasToCreateNew.close();
    list.close();
    pageCount.close();
  }
}
