import 'dart:convert';
import 'dart:typed_data';

import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/rest/CategoryRest.dart';

class CategoryRepository {
  final categoryRest = CategoryRest();

  Future<bool> create(String name, bool isActive, Uint8List? imageByte) async {
    try {
      final data = await categoryRest.create(
          name, isActive, imageByte != null ? base64Encode(imageByte) : null);
      return data.success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> edit(
      int id, String name, bool isActive, Uint8List? imageByte) async {
    try {
      final data = await categoryRest.editCategory(id, name, isActive,
          imageByte != null ? base64Encode(imageByte) : null);
      return data.success;
    } catch (e) {
      return false;
    }
  }

  Future<List<CategoryModel>> list() async {
    final data = await categoryRest.list(0);

    if (data.data != null) {
      if (data.data!.content != null) {
        return data.data!.content!;
      }
    }

    return List.empty();
  }

  Future<List<CategoryModel>> listActive() async {
    final data = await categoryRest.listActive(0);

    if (data.data != null) {
      if (data.data!.content != null) {
        return data.data!.content!;
      }
    }

    return List.empty();
  }

  Future<List<CategoryModel>> searchActive(String query) async {
    final data = await categoryRest.searchListActive(0, query);

    if (data.data != null) {
      if (data.data!.content != null) {
        return data.data!.content!;
      }
    }

    return List.empty();
  }
}
