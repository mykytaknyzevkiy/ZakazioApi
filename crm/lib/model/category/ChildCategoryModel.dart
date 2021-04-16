import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';

class ChildCategoryModel {
  final int id;
  final String name;
  final CategoryModel parent;

  ChildCategoryModel(this.id, this.name, this.parent);

  ChildCategoryModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        parent = CategoryModel.fromJson(json["parent"]);
}
