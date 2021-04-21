import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/DashBoardAnalyticModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zakazy_crm_v2/screen/dashboard/NewDashboardScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderLogsList.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class DashboardChartsWidget extends StatelessWidget {
  final DashBoardAnalytic data;

  DashboardChartsWidget(this.data);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      newOrderAnalytic(),
      financeAnalytic()
    ],
  );

  newOrderAnalytic() => Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardTitle("Новые заказы"),
          SizedBox(
            height: 25
          ),
          Text(
              "Категории",
              style: TextStyle(fontSize: 18),
          ),
          SizedBox(
              height: 15
          ),
          categoryOrderCount(),
          SizedBox(
            height: 15,
          ),
          Text(
            "Регионы",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
              height: 15
          ),
          addressOrderCount(),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        infoText("Всего", formatNumber(data.orderCount)),
                        infoText("Общая сумма", formatNumber(data.totalOrderSum.toInt())),
                      ],
                    ),
                    SizedBox(
                      width: 48,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoText("Партнеры", formatNumber(data.totalOrderPartnerCount)),
                        SizedBox(
                          height: 15,
                        ),
                        infoText("Приложении", formatNumber(data.totalOrderAppCount)),
                        SizedBox(
                          height: 15,
                        ),
                        infoText("Исполнители", formatNumber(data.totalOrderExecutorCount)),
                        SizedBox(
                          height: 15,
                        ),
                        infoText("Клиенты", formatNumber(data.totalOrderClientCount))
                      ],
                    )
                  ],
                )
              ),
              Expanded(child: orderStatus())
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columns: List.generate(
                    data.orderStatus.length,
                        (index) => BaseColumn(data.orderStatus[index].statusInfo().name())
                ),
                rows: [
                  DataRow(
                      cells: List.generate(
                          data.orderStatus.length,
                          (index) => DataCell(Text(formatNumber(data.orderStatus[index].orderCount)))
                      )
                  )
                ],
              ),
            )
          ),
          SizedBox(
            height: 15,
          ),
          orderDate()
        ],
      ),
    ),
  );

  financeAnalytic() => Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardTitle("Финансы"),
          SizedBox(
              height: 25
          ),
          Text(
            "Транзакции по категориям",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
              height: 15
          ),
          categoryOrderTotalPrice(),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  infoText("Заработала система", formatNumber(data.systemInAmount.toInt()) + " руб."),
                  infoText("Партнеры", formatNumber(data.partnerInAmount.toInt()) + " руб."),
                  infoText("Выведено из системы", formatNumber(data.systemOutAmount.toInt()) + " руб.")
                ],
              )
          ),
          SizedBox(
            height: 20,
          ),
          financeDate()
        ],
      ),
    ),
  );

  categoryOrderCount() {
    final scrollController = ScrollController();

    return Scrollbar(
      controller: scrollController,
      isAlwaysShown: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        child: SizedBox(
          width: data.category.length * 150,
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
              primaryYAxis: NumericAxis(
                  axisLine: AxisLine(width: 0),
                  majorGridLines: MajorGridLines(width: 0),
                  majorTickLines: MajorTickLines(size: 0)
              ),
              plotAreaBorderWidth: 0,
              legend: Legend(isVisible: false),
              series: <ColumnSeries<CategoryAnalytic, String>>[
                ColumnSeries<CategoryAnalytic, String>(
                    name: "Кол-во заказов",
                    isTrackVisible: true,
                    trackColor: const Color.fromRGBO(198, 201, 207, 1),
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15),
                    dataSource: data.category,
                    xValueMapper: (e, __) => e.info.name,
                    yValueMapper: (e, __) => e.orderCount,
                    dataLabelSettings: DataLabelSettings(isVisible: true, color: primaryColor, textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: accentColor))
                ),
              ]
          ),
        ),
      ),
    );
  }

  orderDate() =>  SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: false),
      series: <ChartSeries<DateAnalytic, int>>[
        SplineAreaSeries<DateAnalytic, int>(
            name: "Кол-во заказов",
            color: const Color.fromRGBO(75, 135, 185, 0.6),
            borderColor: const Color.fromRGBO(75, 135, 185, 1),
            borderWidth: 2,
            dataSource: data.orderDate,
            xValueMapper: (e, __) => e.date + 1,
            yValueMapper: (e, __) => e.value,
            dataLabelSettings: DataLabelSettings(isVisible: true, color: primaryColor, textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: accentColor))
        ),
      ]
  );

  financeDate() =>  SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: false),
      series: <ChartSeries<DateAnalytic, int>>[
        SplineAreaSeries<DateAnalytic, int>(
            name: "Заработала система",
            color: Colors.green,
            borderColor: Colors.green,
            borderWidth: 2,
            dataSource: data.systemTransactionInDate,
            xValueMapper: (e, __) => e.date + 1,
            yValueMapper: (e, __) => e.value,
            dataLabelSettings: DataLabelSettings(isVisible: true, color: primaryColor, textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: accentColor))
        ),
        /*SplineAreaSeries<DateAnalytic, int>(
            name: "Заработали партнеры",
            color: primaryColor,
            borderColor: primaryColor,
            borderWidth: 2,
            dataSource: data.partnerTransactionInDateAnalytic,
            xValueMapper: (e, __) => e.date + 1,
            yValueMapper: (e, __) => e.value,
            dataLabelSettings: DataLabelSettings(isVisible: true, color: primaryColor, textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: accentColor))
        ),
        SplineAreaSeries<DateAnalytic, int>(
            name: "Вывод из системы",
            color: Colors.red,
            borderColor: Colors.red,
            borderWidth: 2,
            dataSource: data.systemTransactionOutDateAnalytic,
            xValueMapper: (e, __) => e.date + 1,
            yValueMapper: (e, __) => e.value,
            dataLabelSettings: DataLabelSettings(isVisible: true, color: primaryColor, textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: accentColor))
        ),*/
      ]
  );

  categoryOrderTotalPrice() => SfCartesianChart(
      primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0)
      ),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(size: 0),
          isVisible: false
      ),
      tooltipBehavior: TooltipBehavior(
          enable: true,
          header: '',
          canShowMarker: false,
          builder: (data, __, ___, dataIdx, seriesIdx) {
            final value = data as CategoryAnalytic;

            return Card(
              color: primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                    formatNumber( (seriesIdx == 1 ? value.systemTotalPrice : value.orderTotalPrice).toInt() ),
                    style: TextStyle(
                      color: accentColor
                    )
                )
              )
            );
          }
      ),
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true),
      series: <BarSeries<CategoryAnalytic, String>>[
        /*BarSeries<CategoryAnalytic, String>(
            name: "Общая стоимость заказов",
            isTrackVisible: true,
            trackColor: const Color.fromRGBO(198, 201, 207, 1),
            color: primaryColor,
            dataSource: data.category,
            xValueMapper: (e, __) => e.info.name,
            yValueMapper: (e, __) => e.orderTotalPrice / 10000,
        ),*/
        BarSeries<CategoryAnalytic, String>(
            name: "Заработало система",
            isTrackVisible: true,
            trackColor: const Color.fromRGBO(198, 201, 207, 1),
            color: primaryColor,
            dataSource: data.category,
            xValueMapper: (e, __) => e.info.name,
            yValueMapper: (e, __) => e.systemTotalPrice,
        ),
      ]
  );

  addressOrderCount() {
    final scrollController = ScrollController();
    return Scrollbar(
      isAlwaysShown: true,
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: data.address.length * 150,
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
              primaryYAxis: NumericAxis(
                  axisLine: AxisLine(width: 0),
                  majorGridLines: MajorGridLines(width: 0),
                  majorTickLines: MajorTickLines(size: 0)
              ),
              plotAreaBorderWidth: 0,
              legend: Legend(isVisible: false),
              series: <ColumnSeries<AddressAnalytic, String>>[
                ColumnSeries<AddressAnalytic, String>(
                    name: "Кол-во заказов",
                    isTrackVisible: true,
                    trackColor: const Color.fromRGBO(198, 201, 207, 1),
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15),
                    dataSource: data.address,
                    xValueMapper: (e, __) => e.info.name,
                    yValueMapper: (e, __) => e.orderCount,
                    dataLabelSettings: DataLabelSettings(isVisible: true, color: primaryColor, textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: accentColor))
                ),
              ]
          ),
        ),
      )
    );
  }

  addressOrderTotalPrice() => SfCartesianChart(
      primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0)
      ),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(size: 0),
          isVisible: false
      ),
      tooltipBehavior: TooltipBehavior(
          enable: true,
          header: '',
          canShowMarker: false,
          builder: (data, __, ___, dataIdx, seriesIdx) {
            final value = data as AddressAnalytic;

            return Card(
                color: primaryColor,
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                        formatNumber( (seriesIdx == 0 ? value.systemTotalPrice : value.orderTotalPrice).toInt() ),
                        style: TextStyle(
                            color: accentColor
                        )
                    )
                )
            );
          }
      ),
      title: ChartTitle(text: "Финансы по регионам", alignment: ChartAlignment.near),
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true),
      series: <BarSeries<AddressAnalytic, String>>[
        BarSeries<AddressAnalytic, String>(
          name: "Общая стоимость заказов",
          isTrackVisible: true,
          trackColor: const Color.fromRGBO(198, 201, 207, 1),
          color: primaryColor,
          dataSource: data.address.length > 10 ? data.address.sublist(0, 10) : data.address,
          xValueMapper: (e, __) => e.info.name,
          yValueMapper: (e, __) => e.orderTotalPrice / 1000000,
        ),
        BarSeries<AddressAnalytic, String>(
          name: "Заработало система",
          isTrackVisible: true,
          trackColor: const Color.fromRGBO(198, 201, 207, 1),
          color: Colors.green,
          dataSource: data.address.length > 10 ? data.address.sublist(0, 10) : data.address,
          xValueMapper: (e, __) => e.info.name,
          yValueMapper: (e, __) => e.systemTotalPrice,
        ),
      ]
  );

  orderStatus() => SfCircularChart(
    legend: Legend(
        isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
    series: <PieSeries<OrderStatusAnalytic, String>>[
      PieSeries<OrderStatusAnalytic, String>(
          dataSource: data.orderStatus,
          xValueMapper: (OrderStatusAnalytic v, _) => v.statusInfo().name(),
          yValueMapper: (OrderStatusAnalytic v, _) => v.orderCount,
          dataLabelMapper: (OrderStatusAnalytic v, _) => v.statusInfo().name(),
          pointColorMapper: (OrderStatusAnalytic v, _) => v.statusInfo().color(),
          startAngle: 100,
          endAngle: 100,
          pointRadiusMapper: (OrderStatusAnalytic v, _) => "${v.orderCount * 100 / data.orderCount}%" ,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.outside))
    ],
    tooltipBehavior: TooltipBehavior(enable: true),
  );

  cardTitle(String title) => Text(
    title,
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold
    ),
  );

  infoText(String label, String data) => RichText(
    text: TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold
      ),
      children: [
        TextSpan(
          text: "$label:",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.normal
          )
        ),
        TextSpan(
          text: "\n$data",
        )
      ]
    ),
  );
}