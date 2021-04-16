import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/model/category/ChildCategoryModel.dart';
import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';

class ExecutorDashModel {
  final AdminModel executor;
  final List<AdminModel> partners;
  final List<ChildCategoryModel> childCategories;
  final int orderInWorkCount;
  final int orderCancelCount;
  final int orderDoneCount;
  final double ordersSum;
  final double partnerAmount;
  final double systemAmount;

  ExecutorDashModel(
      this.executor,
      this.partners,
      this.childCategories,
      this.orderInWorkCount,
      this.orderCancelCount,
      this.orderDoneCount,
      this.ordersSum,
      this.partnerAmount,
      this.systemAmount);

  ExecutorDashModel.fromJson(Map<String, dynamic> json)
      : executor = AdminModel.fromJson(json["executor"]),
        partners = (json["partners"] as List)
            .map((e) => AdminModel.fromJson(e))
            .toList(),
        childCategories = (json["childCategories"] as List)
            .map((e) => ChildCategoryModel.fromJson(e))
            .toList(),
        orderInWorkCount = json["orderInWorkCount"],
        orderCancelCount = json["orderCancelCount"],
        orderDoneCount = json["orderDoneCount"],
        ordersSum = json["ordersSum"],
        partnerAmount = json["partnerAmount"],
        systemAmount = json["systemAmount"];

  List<CategoryModel> categories() {
    final list = List<CategoryModel>.of({});
    childCategories.forEach((element) {
      if (!list.contains(element.parent)) {
        list.add(element.parent);
      }
    });
    return list;
  }
}
