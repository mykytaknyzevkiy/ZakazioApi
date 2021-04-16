import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/category/ChildCategoryModel.dart';
import 'package:zakazy_crm_v2/repository/FileRepository.dart';
import 'package:zakazy_crm_v2/repository/OrderRepository.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_main.dart';
import 'package:zakazy_crm_v2/screens.dart';

class CreateOrderNewViewModel extends ZakazyViewModel {
  final _orderRepository = OrderRepository();

  final _fileRepository = FileRepository();

  ChildCategoryModel? selectedChildCategory;

  CityModel? selectedCity;

  OrderInfoData? orderInfo;

  OrderPriceData? orderPriceData;

  OrderClientData? orderClientData;

  final isloading = BehaviorSubject<bool>.seeded(false);

  publish(BuildContext context) async {
    isloading.add(true);

    List<String> files = List.of({});

    for (int i = 0; i < orderInfo!.files.length; i++) {
      final uploadFile = await _fileRepository.uploadFile(orderInfo!.files[i]);

      if (uploadFile != null) {
        files.add(uploadFile);
      }
    }

    final data = await _orderRepository.addOrder(
        title: orderInfo!.title,
        content: orderInfo!.content,
        categoryID: selectedChildCategory!.id,
        cityID: selectedCity!.id,
        price: orderPriceData!.price,
        dateLine: orderPriceData!.dateLine,
        clientFirstName: orderClientData!.firstName,
        clientLastName: orderClientData!.lastName,
        clientEmail: orderClientData!.email,
        clientPhone: orderClientData!.phoneNumber,
        clientMiddleName: orderClientData!.middleName,
        fileUrls: files);

    isloading.add(false);

    if (data) {
      ZakazioNavigator.push(context, "order/all");
    }
  }

  @override
  close() {
    isloading.close();
  }
}
