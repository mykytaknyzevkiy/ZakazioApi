import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/dashboard/ExecutorDashModel.dart';
import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';
import 'package:zakazy_crm_v2/widget/payment/OrderTransactionList.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class ExecutorDashTable extends StatelessWidget {
  final List<ExecutorDashModel> data;
  final BuildContext parentContext;

  final scrollController = ScrollController();

  ExecutorDashTable({Key? key, required this.data, required this.parentContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Scrollbar(
      controller: scrollController,
      isAlwaysShown: true,
      child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: Container(
              width: 2000,
              child: DataTable(
                  columns: [
                    BaseColumn("Исполнитель"),
                    BaseColumn("Партнеры с которыми работал"),
                    BaseColumn("Кол-во категорий"),
                    BaseColumn("Кол-во под-категорий"),
                    BaseColumn("Заказов в работе"),
                    BaseColumn("Отменено заказов"),
                    BaseColumn("Успешно завершено заказов"),
                    BaseColumn("Сумма заказов"),
                    BaseColumn("Доход системы"),
                    BaseColumn("Доход партнера")
                  ],
                  rows: data
                      .map((ExecutorDashModel e) => DataRow(cells: [
                            DataCell(Row(
                              children: [
                                UserAvatar(size: 45, user: e.executor),
                                SizedBox(width: 15),
                                Text(
                                    "${e.executor.firstName} ${e.executor.lastName}\n${e.executor.middleName}")
                              ],
                            )),
                            DataCell(Text(e.partners.length.toString())),
                            DataCell(Text(e.categories().length.toString())),
                            DataCell(Text(e.childCategories.length.toString())),
                            DataCell(Text(e.orderInWorkCount.toString())),
                            DataCell(Text(e.orderCancelCount.toString())),
                            DataCell(Text(e.orderDoneCount.toString())),
                            DataCell(Text("${e.ordersSum} руб.")),
                            DataCell(Text("${e.systemAmount} руб.")),
                            DataCell(Text("${e.partnerAmount} руб."))
                          ]))
                      .toList()))));
}
