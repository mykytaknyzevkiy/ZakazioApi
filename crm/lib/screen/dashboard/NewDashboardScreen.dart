import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/DashBoardAnalyticModel.dart';
import 'package:zakazy_crm_v2/model/dashboard/DashboardModel.dart';
import 'package:zakazy_crm_v2/model/dashboard/ExecutorDashModel.dart';
import 'package:zakazy_crm_v2/model/order/OrderStatus.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';
import 'package:zakazy_crm_v2/repository/PaymentRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/dashboard/DashboardChartsWidget.dart';
import 'package:zakazy_crm_v2/screen/dashboard/DashboardViewModel.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fl_chart/fl_chart.dart';
import 'package:zakazy_crm_v2/screen/dashboard/ExecutorDashTable.dart';
import 'package:zakazy_crm_v2/screen/dashboard/widget/dashboard_finance_widget.dart';
import 'package:zakazy_crm_v2/screen/dashboard/widget/dashboard_order_count_widget.dart';
import 'package:zakazy_crm_v2/screen/dashboard/widget/dashboard_userinfo_widget.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/chart/BarChartSample1.dart';
import 'package:zakazy_crm_v2/widget/chart/LineChartSample2.dart';
import 'package:zakazy_crm_v2/widget/chart/PieChartSample2.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';
import 'package:zakazy_crm_v2/widget/chart/TopUserOrderChart.dart';
import 'package:zakazy_crm_v2/widget/payment/OrderTransactionList.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class NewDashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewDashboardScreenState();
}

class _NewDashboardScreenState
    extends HomeScreen<NewDashboardScreen, DashboardViewModel> {
  final _paymentRepository = PaymentRepository();

  late DashboardViewModel _viewModel = viewModel();

  /*@override
  void initState() {
    _viewModel.systemLoad();
    super.initState();
  }*/

  @override
  Widget top() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
        ),
        Divider(
          height: 25,
          color: Colors.transparent,
        ),
        StreamBuilder<MapEntry<DateType, DateInto?>>(
            stream: _viewModel.selectedDates,
            builder: (context, snapShot) {
              if (!snapShot.hasData) return CircularProgressIndicator();
              _viewModel.systemLoad();
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  MyButton(
                    title: "Неделя",
                    onPressed: () => _viewModel.setDate(DateType.WEEK, null),
                    isEnable: true,
                    backgroundColor: snapShot.requireData.key == DateType.WEEK
                        ? primaryColor
                        : accentColor,
                    foregroundColor: snapShot.requireData.key == DateType.WEEK
                        ? accentColor
                        : primaryColor,
                  ),
                  MyButton(
                    title: "Месяц",
                    onPressed: () => _viewModel.setDate(DateType.MONTH, null),
                    isEnable: true,
                    backgroundColor: snapShot.requireData.key == DateType.MONTH
                        ? primaryColor
                        : accentColor,
                    foregroundColor: snapShot.requireData.key == DateType.MONTH
                        ? accentColor
                        : primaryColor,
                  ),
                  MyButton(
                    title: "Год",
                    onPressed: () => _viewModel.setDate(DateType.YEAR, null),
                    isEnable: true,
                    backgroundColor: snapShot.requireData.key == DateType.YEAR
                        ? primaryColor
                        : accentColor,
                    foregroundColor: snapShot.requireData.key == DateType.YEAR
                        ? accentColor
                        : primaryColor,
                  ),
                  MyButton(
                    title: "Установить",
                    onPressed: () async {
                      final rangeDate = await showDateRangePicker(
                          context: this.context,
                          initialEntryMode: DatePickerEntryMode.input,
                          firstDate: DateTime(2020, 1, 1),
                          lastDate: DateTime(2025, 1, 1));
                      if (rangeDate != null) {
                        _viewModel.setDate(DateType.CUSTOM,
                            DateInto(rangeDate.start, rangeDate.end));
                      }
                    },
                    isEnable: true,
                    backgroundColor: snapShot.requireData.key == DateType.CUSTOM
                        ? primaryColor
                        : accentColor,
                    foregroundColor: snapShot.requireData.key == DateType.CUSTOM
                        ? accentColor
                        : primaryColor,
                  ),
                ],
              );
            })
      ],
    );
  }

  @override
  Widget body() => StreamBuilder(
    stream: _viewModel.selectedDates,
    builder: (_, snapshot) => snapshot.hasData
      ? SizedBox(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          MediaQuery.of(context).size.width > phoneSize
              ? FutureBuilder<DashBoardAnalytic>(
              future: _viewModel.analytic(),
              builder: (_, snapShot) {
                if (!snapShot.hasData) {
                  return Center(
                      child: CircularProgressIndicator()
                  );
                }
                return DashboardChartsWidget(snapShot.requireData);
              }
          )
              : Container(),
          SizedBox(
            height: 25,
          ),
          MediaQuery.of(context).size.width > phoneSize
              ? _executorDashTable()
              : Container()
        ])
    )
    : Center(
      child: CircularProgressIndicator()
    )
  );

  _executorDashTable() => Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Отчет по исполнителям",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 25),
              FutureBuilder<List<ExecutorDashModel>>(
                  future: _viewModel.executorsTableData(),
                  builder: (context, snapShot) {
                    if (!snapShot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ExecutorDashTable(
                        data: snapShot.requireData, parentContext: context);
                  })
            ],
          ),
        ),
      );

  _topPartner(List<KeyValue<AdminModel>> partners) => Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Активные партнеры",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 25),
          SizedBox(
              width: double.infinity,
              child: DataTable(
                  columns: [
                    BaseColumn("ID"),
                    BaseColumn("Имя"),
                    BaseColumn("Кол-во заказов"),
                    BaseColumn("Действие")
                  ],
                  rows: List.generate(partners.length, (index) {
                    final user = partners[index].key;
                    final orderCount = partners[index].value;
                    return DataRow(cells: [
                      DataCell(Text(user.id.toString())),
                      DataCell(Row(
                        children: [
                          UserAvatar(
                            size: 45,
                            user: user,
                          ),
                          SizedBox(width: 15),
                          Text(
                              "${user.firstName} ${user.lastName}\n${user.middleName}")
                        ],
                      )),
                      DataCell(Text(formatNumber(orderCount))),
                      DataCell(SmallButton(
                          title: "В профиль",
                          onPressed: () => ZakazioNavigator.pushWParams(
                              "user/profile", {"userID": user.id}),
                          isEnable: true))
                    ]);
                  })))
        ]),
      ));

  _topExecutor(List<KeyValue<AdminModel>> partners) => Card(
      elevation: 4,
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Активные исполнители",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                    columns: [
                      BaseColumn("ID"),
                      BaseColumn("Имя"),
                      BaseColumn("Кол-во заказов"),
                      BaseColumn("Действие")
                    ],
                    rows: List.generate(partners.length, (index) {
                      final user = partners[index].key;
                      final orderCount = partners[index].value;
                      return DataRow(cells: [
                        DataCell(Text(user.id.toString())),
                        DataCell(Row(
                          children: [
                            UserAvatar(
                              size: 45,
                              user: user,
                            ),
                            SizedBox(width: 15),
                            Text(
                                "${user.firstName} ${user.lastName}\n${user.middleName}")
                          ],
                        )),
                        DataCell(Text(formatNumber(orderCount))),
                        DataCell(SmallButton(
                            title: "В профиль",
                            onPressed: () => ZakazioNavigator.pushWParams(
                                "user/profile", {"userID": user.id}),
                            isEnable: true))
                      ]);
                    })),
              )
            ],
          )));

  @override
  int selectedIndex() => 0;

  @override
  DashboardViewModel viewModelInstancer() => DashboardViewModel();
}

Widget dashCard(String label, String data, IconData icon) => Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Container(
            width: 300,
            constraints: BoxConstraints(minHeight: 100),
            child: Column(children: [
              SizedBox(
                width: 130,
                child: Text(
                  label,
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
              Divider(
                height: 30,
                color: Colors.transparent,
              ),
              SizedBox(
                width: 130,
                child: Text(
                  data,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24),
                ),
              )
            ], crossAxisAlignment: CrossAxisAlignment.start)),
      ),
    );

String formatNumber(int num) {
  if (num <= 999) {
    return num.toString();
  }

  NumberFormat formatter;

  if (num <= 9999)
    formatter = NumberFormat('#,###');
  else if (num <= 99999)
    formatter = NumberFormat('##,###');
  else if (num <= 999999)
    formatter = NumberFormat('###,###');
  else if (num <= 9999999)
    formatter = NumberFormat('#,###,###');
  else if (num <= 99999999)
    formatter = NumberFormat('##,###,###');
  else if (num <= 999999999)
    formatter = NumberFormat('###,###,###');
  else if (num <= 9999999999)
    formatter = NumberFormat('#,###,###,###');
  else
    formatter = NumberFormat.currency(locale: 'rub');

  return formatter.format(num).replaceAll(",", " ");
}
