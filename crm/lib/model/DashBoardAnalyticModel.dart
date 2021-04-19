import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/address/RegionModel.dart';
import 'package:zakazy_crm_v2/model/category/ChildCategoryModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderStatus.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

import 'category/CategoryModel.dart';

class DashBoardAnalytic {
  final List<CategoryAnalytic> category;
  final List<AddressAnalytic> address;
  final List<OrderStatusAnalytic> orderStatus;

  DashBoardAnalytic(this.category, this.address, this.orderStatus);

  DashBoardAnalytic.fromJson(Map<String, dynamic> json):
        category = (json["category"] as List).map((e) => CategoryAnalytic.fromJson(e)).toList(),
        address = (json["address"] as List).map((e) => AddressAnalytic.fromJson(e)).toList(),
        orderStatus = (json["orderStatus"] as List).map((e) => OrderStatusAnalytic.fromJson(e)).toList();

  int maxCategoryOrderCount() {
    int max = 0;
    category.forEach((e) {
      if (max < e.orderCount) {
        max = e.orderCount;
      }
    });
    return max;
  }

  double maxCategoryOrderTotalPrice() {
    double max = 0;
    category.forEach((e) {
      if (max < e.orderTotalPrice) {
        max = e.orderTotalPrice;
      }
    });
    return max;
  }
}

abstract class SampleAnalytic {
  final int orderCount;
  final int executorCount;
  final int partnerCount;
  final double orderTotalPrice;
  final double systemTotalPrice;

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
      CityModel.fromJson(json["info"]),
      json
  );
}

class AddressAnalytic extends SampleAnalytic {
  final RegionModel info;
  final List<CityAnalytic> cityList;

  AddressAnalytic(this.info, this.cityList, Map<String, dynamic> json) : super(json);

  static AddressAnalytic fromJson(Map<String, dynamic> json) => AddressAnalytic(
      RegionModel.fromJson(json["info"]),
      (json["cityList"] as List).map((e) => CityAnalytic.fromJson(e)).toList(),
      json
  );
}

class OrderStatusAnalytic {
  final String info;
  final int orderCount;

  OrderStatusAnalytic(this.info, this.orderCount);

  OrderStatus statusInfo() => findStatus(info);

  OrderStatusAnalytic.fromJson(Map<String, dynamic> json):
        info = json['info'],
        orderCount = json['orderCount'];
}