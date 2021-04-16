import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/help/help_request_model.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/help/list/help_list_vm.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/payment/OrderTransactionList.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class HelpListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HelpListState();
}

class _HelpListState extends HomeScreen<HelpListScreen, HelpListViewModel> {
  @override
  void initState() {
    viewModel().load(0);
    super.initState();
  }

  @override
  Widget body() => Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: StreamBuilder<PagedListModel<HelpRequestModel>>(
              stream: viewModel().list,
              builder: (_, snapShot) {
                if (!snapShot.hasData)
                  return Center(child: CircularProgressIndicator());
                return table(snapShot.requireData);
              }),
        ),
      );

  table(PagedListModel<HelpRequestModel> data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: DataTable(
              showCheckboxColumn: false,
              columns: [
                BaseColumn("ID"),
                BaseColumn("Пользователь"),
                BaseColumn("Статус"),
                BaseColumn("Дата")
              ],
              rows: List.generate(data.content!.length, (index) {
                final HelpRequestModel item = data.content![index];
                return DataRow(
                    onSelectChanged: (_) {
                      ZakazioNavigator.pushWParams(
                          "help/info", {"id": item.id});
                    },
                    cells: [
                      DataCell(Text(item.id.toString())),
                      DataCell(Row(
                        children: [
                          UserAvatar(
                            size: 45,
                            user: item.user,
                          ),
                          SizedBox(width: 15),
                          Text(
                              "${item.user.firstName} ${item.user.lastName}\n${item.user.middleName}")
                        ],
                      )),
                      DataCell(Text(item.status)),
                      DataCell(Text(item.dateStr()))
                    ]);
              }),
            ),
          ),
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          PagesWidget(
              pageLength: data.totalPages,
              currentPage: data.number,
              onSelect: viewModel().load)
        ],
      );

  @override
  Widget top() => createTitleView("Запросы на помошь");

  @override
  HelpListViewModel viewModelInstancer() => HelpListViewModel();
}
