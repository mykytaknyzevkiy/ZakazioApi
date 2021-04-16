import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/transaction/TransactionModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderInfoViewModel.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class OrderTransactionList extends StatelessWidget {
  final OrderInfoViewModel _viewModel =
      ViewModelProvider<OrderInfoViewModel>().build(() => OrderInfoViewModel());

  @override
  Widget build(BuildContext context) => Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Транзакции",
                style: TextStyle(fontSize: 16),
              ),
              Divider(
                height: 25,
                color: Colors.transparent,
              ),
              StreamBuilder<PagedListModel<TransactionModelImp>>(
                  stream: _viewModel.transactions,
                  builder: (context, snapShot) {
                    if (!snapShot.hasData)
                      return Center(child: CircularProgressIndicator());

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: MediaQuery.of(context).size.width > phoneSize
                          ? _Desktop(snapShot.requireData.content!)
                          : _Mobile(snapShot.requireData.content!)
                        ),
                        Divider(height: 20, color: Colors.transparent),
                        PagesWidget(
                            pageLength: snapShot.requireData.totalPages,
                            currentPage: snapShot.requireData.number,
                            onSelect: _viewModel.loadTransactions)
                      ],
                    );
                  })
            ],
          ),
        ),
      );
}

class BaseColumn extends DataColumn {
  BaseColumn(String title)
      : super(
            label: Text(
          title,
          style: TextStyle(fontStyle: FontStyle.italic),
        ));
}

class BaseCell extends DataCell {
  BaseCell(String title) : super(
    Text(title)
  );
}

class _Desktop extends StatelessWidget {
  final List<TransactionModelImp> list;

  const _Desktop(this.list);

  _tableColumns() => [
    BaseColumn("Пользователь"),
    BaseColumn("Сумма"),
    BaseColumn("Дата"),
  ];

  List<DataRow> _tableRows(List<TransactionModelImp> list) => list
      .map((e) => DataRow(
    /*color: MaterialStateColor.resolveWith((states) =>
                  e.operation == "MINUS"
                      ? Colors.green.withAlpha(50)
                      : Colors.yellow.withAlpha(50)),*/
      cells: [
        DataCell(Row(
          children: [
            UserAvatar(
              size: 45,
              user: e.user,
            ),
            SizedBox(width: 15),
            Text(
                "${e.user.firstName} ${e.user.lastName}\n${e.user.middleName}")
          ],
        )),
        DataCell(Text(
            "${e.operation == "MINUS" ? 'Ввел' : 'Получил'} ${e.amount}")),
        DataCell(Text(e.dateStr()))
      ]))
      .toList();

  @override
  Widget build(BuildContext context) => DataTable(
      columns: _tableColumns(),
      rows: _tableRows(list)
  );
}

class _Mobile extends StatelessWidget {
  final List<TransactionModelImp> list;

  const _Mobile(this.list);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(list.length, (index) => viewHolder(list[index])),
  );

  viewHolder(TransactionModelImp e) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Divider(
        height: 15,
        color: Colors.transparent,
      ),
      Row(
        children: [
          UserAvatar(
            size: 45,
            user: e.user,
          ),
          SizedBox(width: 15),
          Text(
              "${e.user.firstName} ${e.user.lastName}\n${e.user.middleName}")
        ],
      ),
      Divider(
        height: 15,
        color: Colors.transparent,
      ),
      Text(
          "${e.operation == "MINUS" ? 'Ввел' : 'Получил'} ${e.amount}"),
      Divider(
        height: 5,
        color: Colors.transparent,
      ),
      Text(
          e.dateStr(),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12
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
  );
}