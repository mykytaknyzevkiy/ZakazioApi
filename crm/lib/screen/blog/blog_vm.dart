import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/blog/blog_model.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/blog_rest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class BlogViewModel extends ZakazyViewModel {
  final _blogRest = BlogRest();

  final list = BehaviorSubject<PagedListModel<BlogModel>>();

  final onEdit = BehaviorSubject<MapEntry<bool, int?>>();

  int lastPageIdx = 0;

  load(int pageIdx) async {
    lastPageIdx = pageIdx;
    final data = await _blogRest.list(pageIdx);
    if (data.success) {
      list.add(data.data);
    }
  }

  Future<BlogModel> info(int id) async {
    final data = await _blogRest.info(id);
    return data.data!;
  }

  edit(
      int id, String title, String content, PlatformFile? wallpaperFile) async {
    final String? wallpaper64 =
        (wallpaperFile != null) ? base64Encode(wallpaperFile.bytes) : null;

    await _blogRest.edit(id, title, content, wallpaper64);

    load(lastPageIdx);

    onEdit.add(null);
  }

  save(String title, String content, PlatformFile wallpaperFile) async {
    final String wallpaper64 = base64Encode(wallpaperFile.bytes);

    await _blogRest.add(title, content, wallpaper64);

    load(0);

    onEdit.add(null);
  }

  remove(int id) async {
    await _blogRest.remove(id);

    load(lastPageIdx);

    onEdit.add(null);
  }

  @override
  close() {
    list.close();
    onEdit.close();
  }
}
