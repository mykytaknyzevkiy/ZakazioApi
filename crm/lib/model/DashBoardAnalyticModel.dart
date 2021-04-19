import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/address/RegionModel.dart';
import 'package:zakazy_crm_v2/model/category/ChildCategoryModel.dart';

import 'category/CategoryModel.dart';

class DashBoardAnalytic {
  final CategoryAnalytic category;
  final AddressAnalytic address;

  DashBoardAnalytic(this.category, this.address);

  DashBoardAnalytic.fromJson(Map<String, dynamic> json):
        category = CategoryAnalytic.fromJson(json["category"]),
        address = AddressAnalytic.fromJson(json["address"]);
}

abstract class SampleAnalytic {
  final int orderCount;
  final int executorCount;
  final int partnerCount;
  final int orderTotalPrice;
  final int systemTotalPrice;

  SampleAnalytic(Map<String, dynamic> json) :
        orderCount = json['orderCount'],
        executorCount = json['executorCount'],
        partnerCount = json['partnerCount'],
        orderTotalPrice = json['orderTotalPrice'],
        systemTotalPrice = json['systemTotalPrice'];
}

class ChildCategoryAnalytic extends SampleAnalytic {
  final ChildCategoryModel info;

  ChildCategoryAnalytic(this.info, Map<String, dynamic> json) : super(json);

  static ChildCategoryAnalytic fromJson(Map<String, dynamic> json) => ChildCategoryAnalytic(
      ChildCategoryModel.fromJson(json['info']),
      json
  );
}

class CategoryAnalytic extends SampleAnalytic {
  final CategoryModel info;
  final List<ChildCategoryAnalytic> childList;

  CategoryAnalytic(this.info, this.childList, Map<String, dynamic> json) : super(json);

  static CategoryAnalytic fromJson(Map<String, dynamic> json) => CategoryAnalytic(
      CategoryModel.fromJson(json['info']),
      (json['childList'] as List).map((e) => ChildCategoryAnalytic.fromJson(e)).toList(),
      json
  );
}

class CityAnalytic extends SampleAnalytic {
  final CityModel info;

  CityAnalytic(this.info, Map<String, dynamic> json) : super(json);

  static CityAnalytic fromJson(Map<String, dynamic> json) => CityAnalytic(
      json["info"],
      json
  );
}

class AddressAnalytic extends SampleAnalytic {
  final RegionModel info;
  final List<CityAnalytic> cityList;

  AddressAnalytic(this.info, this.cityList, Map<String, dynamic> json) : super(json);

  static AddressAnalytic fromJson(Map<String, dynamic> json) => AddressAnalytic(
      json["info"],
      (json["cityList"] as List).map((e) => CityAnalytic.fromJson(e)).toList(),
      json
  );
}