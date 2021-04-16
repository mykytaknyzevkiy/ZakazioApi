import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/dashboard/DashboardModel.dart';
import 'package:zakazy_crm_v2/screen/dashboard/NewDashboardScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderLogsList.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class UserInfoBlockWidget extends StatelessWidget {
  final List<KeyValue<String>> data;

  const UserInfoBlockWidget(this.data);

  @override
  Widget build(BuildContext context) => MediaQuery.of(context).size
      .width > phoneSize
      ? desktop()
      : mobile();

  desktop() {
    final colums = List<DataColumn>.of({});
    colums.add(BaseColumn("Всего"));
    data.forEach((element) {
      colums.add(BaseColumn(findRoleType(element.key).name()));
    });

    int total = 0;
    data.forEach((element) {
      total += element.value.toInt();
    });

    final rowCells = List<DataCell>.of({});
    rowCells.add(DataCell(Text(formatNumber(total).toString())));

    data.forEach((element) {
      rowCells.add(DataCell(Text(formatNumber(element.value).toString())));
    });

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Новые пользователи",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                columns: colums,
                rows: [DataRow(cells: rowCells)],
              ),
            )
          ],
        ),
      ),
    );
  }

  mobile() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Новые пользователи",
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(height: 15),
      Column(
        children: List.generate(
            data.length, (index) => dashCard(data[index].key, formatNumber(data[index].value), Icons.account_box)),
      )
    ],
  );
}