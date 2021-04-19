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
  Widget build(BuildContext context) => Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Аналитика",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 25),
          categoryOrderCount(),
          SizedBox(height: 15),
          categoryOrderTotalPrice(),
          SizedBox(height: 15),
          addressOrderCount(),
          SizedBox(height: 15),
          orderStatus()
        ],
      ),
    )
  );

  categoryOrderCount() => SfCartesianChart(
      primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(size: 0)
      ),
      title: ChartTitle(text: "Категории заказы", alignment: ChartAlignment.near),
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
                    formatNumber( (seriesIdx == 0 ? value.systemTotalPrice : value.orderTotalPrice).toInt() ),
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
      title: ChartTitle(text: "Заказы по регионам", alignment: ChartAlignment.near),
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

  orderStatus() {
    int totalOrderCount = 0;
    data.orderStatus.forEach((element) {
      totalOrderCount += element.orderCount;
    });

    return SfCircularChart(
      title: ChartTitle(
          text: 'Статусы по заказам'
      ),
      legend: Legend(
          isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: <PieSeries<OrderStatusAnalytic, String>>[
        PieSeries<OrderStatusAnalytic, String>(
            dataSource: data.orderStatus,
            xValueMapper: (OrderStatusAnalytic v, _) => v.statusInfo().name(),
            yValueMapper: (OrderStatusAnalytic v, _) => v.orderCount,
            dataLabelMapper: (OrderStatusAnalytic v, _) => v.statusInfo().name(),
            startAngle: 100,
            endAngle: 100,
            pointRadiusMapper: (OrderStatusAnalytic v, _) => "${v.orderCount * 100 / totalOrderCount}%" ,
            dataLabelSettings: DataLabelSettings(
                isVisible: true, labelPosition: ChartDataLabelPosition.outside))
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

}