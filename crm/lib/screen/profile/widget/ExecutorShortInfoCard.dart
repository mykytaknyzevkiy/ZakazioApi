import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';

class ExecutorShortInfoCard extends StatelessWidget {
  final ExecutorModel _executor;

  const ExecutorShortInfoCard(this._executor);

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 300,
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Статус по заказам",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          dataInfoField(
              "В процессе", _executor.order.count.open.toString()),
          Divider(
            height: 10,
            color: Colors.transparent,
          ),
          dataInfoField(
              "Завершено", _executor.order.count.close.toString()),
          Divider(
            height: 10,
            color: Colors.transparent,
          ),
          dataInfoField(
              "Отказов", _executor.order.count.declined.toString()),
          Divider(
            height: 10,
            color: Colors.transparent,
          ),
          dataInfoField("Макс доступное заказов в процессе",
              _executor.order.count.max.toString())
        ],
      ),
    ),
  );
}
