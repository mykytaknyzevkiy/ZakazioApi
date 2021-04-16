import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/model/category/ChildCategoryModel.dart';

class GlobalCategory {
  final CategoryModel parent;
  final List<ChildCategoryModel> childList;

  GlobalCategory(this.parent, this.childList);

  GlobalCategory.fromJson(Map<String, dynamic> json)
      : parent = CategoryModel.fromJson(json["parent"]),
        childList = (json["childList"] as List)
            .map((e) => ChildCategoryModel.fromJson(e))
            .toList();
}
