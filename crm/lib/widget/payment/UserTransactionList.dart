import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/transaction/TransactionModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderLogsList.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';

class UserTransactionList extends StatelessWidget {
  final BehaviorSubject<PagedListModel<TransactionModelImp>> data;
  final Function(int pageIndex) onLoad;

  const UserTransactionList(
      {
        Key? key,
        required this.data,
        required this.onLoad
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onLoad.call(0);
    return StreamBuilder<PagedListModel<TransactionModelImp>>(
        stream: data,
        builder: (context, snapShot) {
          if (!snapShot.hasData)
            return Center(
                child: CircularProgressIndicator()
            );

          /*if (MediaQuery.of(context).size.width <= phoneSize) {
        return Container();
      }*/

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediaQuery.of(context).size.width > phoneSize
                  ? _Desktop(snapShot.requireData.content!)
                  : _Mobile(snapShot.requireData.content!),
              Divider(height: 20, color: Colors.transparent),
              PagesWidget(
                  pageLength: snapShot.requireData.totalPages,
                  currentPage: snapShot.requireData.number,
                  onSelect: onLoad)
            ],
          );
        }
    );
  }

}

class _Desktop extends StatelessWidget {
  final List<TransactionModelImp> list;

  const _Desktop(this.list);

  _tableColumns() => [
    BaseColumn("Сумма"),
    BaseColumn("Заказ/Карта"),
    BaseColumn("Дата"),
  ];

  List<DataRow> _tableRows() => list.map((e) =>
      DataRow(
          cells: [
            DataCell(
                Text(
                    "${e.operation == "MINUS" ? '-' : '+'} ${e.amount}"
                )
            ),
            DataCell(
                GestureDetector(
                  onTap: () {
                    if (e.order != null) {
                      ZakazioNavigator.pushWParams("order/info", {"id": e.order!.id});
                    }
                  },
                  child: (e.order != null)
                      ? Text(
                      "Заказ №${e.order!.id}"
                  )
                      : Text(
                      "Карта"
                  ),
                )
            ),
            DataCell(
                Text(e.dateStr())
            )
          ]
      )
  ).toList();

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: DataTable(
        columns: _tableColumns(),
        rows: _tableRows()
    ),
  );
}

class _Mobile extends StatelessWidget {
  final List<TransactionModelImp> list;

  const _Mobile(this.list);

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list.map((e) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${e.operation == "MINUS" ? '-' : '+'} ${e.amount}",
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          Divider(
            height: 10,
            color: Colors.transparent,
          ),
          buildRichTextHorizontal((e.order != null) ? "Заказ №" : "Карта", (e.order != null) ? e.order!.id.toString() : e.card!.endNum),
          Text(
            e.dateStr(),
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey
            ),
          ),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          )
        ],
      )).toList(),
    )
  );
}