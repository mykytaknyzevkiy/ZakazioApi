import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/repository/OrderRepository.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/order/AdaptiveOrderList.dart';
import 'package:zakazy_crm_v2/widget/order/OrderNewViewHolder.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

import '../../../screens.dart';

class UserOrderlistWidget extends StatefulWidget {
  final UserInfoModel user;

  UserOrderlistWidget(this.user);

  @override
  State<StatefulWidget> createState() => _UserOrderlistWidget(user);
}

// ignore: must_be_immutable
class _UserOrderlistWidget extends State<UserOrderlistWidget> {
  final UserInfoModel user;

  final _orderRepository = OrderRepository();

  final _ordersPaged = BehaviorSubject<PagedListModel<OrderModel>>.seeded(null);

  int _currentPage = 0;

  _UserOrderlistWidget(this.user);

  @override
  Widget build(BuildContext context) {
    _loadData();
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Заказы",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(
              height: 25,
              color: Colors.transparent,
            ),
            AdaptiveOrderList(
              stream: _ordersPaged,
              onLoad: (index) {
                _currentPage = index;
                _loadData();
              },
            )
          ],
        )
      )
    );
  }

  _tables(List<OrderModel> data) {
    return DataTable(
      columnSpacing: 0,
      showCheckboxColumn: false,
      dataRowHeight: 120,
      showBottomBorder: true,
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Заказчик',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Название',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Категория',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Сумма',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Дата',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Статус',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: List<DataRow>.generate(
          data.length, (index) => _tableRow(data[index])),
    );
  }

  _tableRow(OrderModel order) => DataRow(
          cells: [
            DataCell(Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserAvatar(
                  size: 55,
                  user: order.client,
                ),
                Divider(
                  height: 5,
                  color: Colors.transparent,
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    "${order.client.firstName} "
                        "${order.client.lastName}"
                        "\n${order.client.middleName}"
                  ),
                )
              ],
            )),
            DataCell(SizedBox(
              width: 100,
              child: Text(order.title),
            )),
            DataCell(SizedBox(
              width: 125,
              child: Text(order.category.name),
            )),
            DataCell(Text("${order.price} руб.")),
            DataCell(
              SizedBox(
                width: 80,
                child: Text(order.dateStr()),
              )
            ),
            DataCell(Text(
              order.statusInfo().name(),
              style: TextStyle(color: order.statusInfo().color()),
            )),
          ],
          onSelectChanged: (_) => {
                ZakazioNavigator.pushWParams("order/info", {"id": order.id})
              });

  _loadData() async {
    _ordersPaged.add(null);
    final data = await _orderRepository.userOrders(user.id, _currentPage, "", 3);
    _ordersPaged.add(data);
  }

  close() {
    _ordersPaged.close();
  }
}
