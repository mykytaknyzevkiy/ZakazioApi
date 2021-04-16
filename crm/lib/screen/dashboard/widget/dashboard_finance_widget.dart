import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/dashboard/DashboardModel.dart';
import 'package:zakazy_crm_v2/screen/dashboard/NewDashboardScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderLogsList.dart';

class FinanceBlockWidget extends StatelessWidget {
  final DashboardModel data;

  FinanceBlockWidget(this.data);

  @override
  Widget build(BuildContext context) => MediaQuery.of(context).size
      .width > phoneSize
      ? desktop()
      : mobile();

  desktop() => Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Финансы",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: [
                BaseColumn("Система"),
                BaseColumn("Партнеры"),
                BaseColumn("По завершению"),
                BaseColumn("Вывод средств")
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("${formatNumber(data.transaction.systemTotalSum)} руб.")),
                  DataCell(
                      Text("${formatNumber(data.transaction.totalPartnerSum)} руб.")),
                  DataCell(Text(
                      "${formatNumber(data.transaction.totalSystemReceiveSum)} руб.")),
                  DataCell(Text("${formatNumber(data.transaction.totalOutCardSum)} руб."))
                ])
              ],
            ),
          )
        ],
      ),
    ),
  );

  mobile() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Финансы",
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(height: 15),
      dashCard("Система", "${formatNumber(data.transaction.systemTotalSum)} руб.", Icons.attach_money),
      dashCard("Партнеры", "${formatNumber(data.transaction.totalPartnerSum)} руб.", Icons.attach_money),
      dashCard("По завершению", "${formatNumber(data.transaction.totalSystemReceiveSum)} руб.", Icons.attach_money),
      dashCard("Вывод средств", "${formatNumber(data.transaction.totalOutCardSum)} руб.", Icons.attach_money)
    ],
  );
}