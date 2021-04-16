import 'dart:typed_data';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/model/category/ChildCategoryModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/repository/CategoryRepository.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class CategoryViewModel extends ZakazyViewModel {
  CategoryViewModel() {
    loadList();
  }

  final _categoryRepository = CategoryRepository();

  final BehaviorSubject<MapEntry<bool, CategoryModel?>> toCreateCategory =
      BehaviorSubject.seeded(null);

  final BehaviorSubject<MapEntry<bool, ChildCategoryModel?>>
      toChildCreateCategory = BehaviorSubject.seeded(null);

  final BehaviorSubject<List<CategoryModel>> categoryList =
      BehaviorSubject.seeded(List.empty());

  final BehaviorSubject<PagedListModel<ChildCategoryModel>> childCategoryList =
      BehaviorSubject();

  Future<bool> add(String name, bool isActive, Uint8List? imageByte) async {
    final data = await _categoryRepository.create(name, isActive, imageByte);

    if (data) {
      toCreateCategory.add(null);
      loadList();
    }

    return data;
  }

  Future<bool> edit(
      int id, String name, bool isActive, Uint8List? imageByte) async {
    final data = await _categoryRepository.edit(id, name, isActive, imageByte);

    if (data) {
      toCreateCategory.add(null);
      loadList();
    }

    return data;
  }

  addChild(int parentID, String name) async {
    final data =
        await _categoryRepository.categoryRest.addChildCategory(parentID, name);

    if (data.success) {
      toChildCreateCategory.add(null);
      loadChildList(parentID, 0);
    }
  }

  editChild(int id, int parentID, String name) async {
    final data =
        await _categoryRepository.categoryRest.editChildCategory(parentID, id, name);

    if (data.success) {
      toChildCreateCategory.add(null);
      loadChildList(parentID, 0);
    }
  }

  loadList() async {
    final list = await _categoryRepository.list();

    categoryList.add(list);
  }

  loadChildList(int parentID, int pageIndex) async {
    childCategoryList.add(null);

    final data = await _categoryRepository.categoryRest
        .childList(parentID, "", pageIndex);

    if (data.success) {
      childCategoryList.add(data.data!);
    }
  }

  close() {
    toCreateCategory.close();
    categoryList.close();
    childCategoryList.close();
    toChildCreateCategory.close();
  }
}
