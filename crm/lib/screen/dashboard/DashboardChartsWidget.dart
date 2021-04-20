import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/DashBoardAnalyticModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zakazy_crm_v2/screen/dashboard/NewDashboardScreen.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class DashboardChartsWidget extends StatelessWidget {
  final DashBoardAnalytic data;

  DashboardChartsWidget(this.data);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      newOrderAnalytic()
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
                    infoText("Всего", formatNumber(data.orderCount)),
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
          )
        ],
      ),
    ),
  );

  categoryOrderCount() => SfCartesianChart(
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
      title: ChartTitle(text: "Категории транзакции", alignment: ChartAlignment.near),
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true),
      series: <BarSeries<CategoryAnalytic, String>>[
        BarSeries<CategoryAnalytic, String>(
            name: "Общая стоимость заказов",
            isTrackVisible: true,
            trackColor: const Color.fromRGBO(198, 201, 207, 1),
            color: primaryColor,
            dataSource: data.category,
            xValueMapper: (e, __) => e.info.name,
            yValueMapper: (e, __) => e.orderTotalPrice / 10000,
        ),
        BarSeries<CategoryAnalytic, String>(
            name: "Заработало система",
            isTrackVisible: true,
            trackColor: const Color.fromRGBO(198, 201, 207, 1),
            color: Colors.green,
            dataSource: data.category,
            xValueMapper: (e, __) => e.info.name,
            yValueMapper: (e, __) => e.systemTotalPrice,
        ),
      ]
  );


  addressOrderCount() => SfCartesianChart(
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
            dataSource: data.address.length > 10 ? data.address.sublist(0, 10) : data.address,
            xValueMapper: (e, __) => e.info.name,
            yValueMapper: (e, __) => e.orderCount,
            dataLabelSettings: DataLabelSettings(isVisible: true, color: primaryColor, textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: accentColor))
        ),
      ]
  );

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