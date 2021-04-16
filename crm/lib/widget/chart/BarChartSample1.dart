// ignore: import_of_legacy_library_into_null_safe
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:hexcolor/hexcolor.dart';
import 'package:zakazy_crm_v2/conts.dart';

class BarChartSample1 extends StatefulWidget {
  final Map<String, double> data;
  final String label;

  const BarChartSample1({Key? key, required this.data, required this.label}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample1State(data, label);
}

class BarChartSample1State extends State<BarChartSample1> {
  final Map<String, double> data;
  final String label;

  final Color barBackgroundColor = HexColor("#ebebeb");
  final Duration animDuration = const Duration(milliseconds: 250);

  int? touchedIndex;

  bool isPlaying = false;

  BarChartSample1State(this.data, this.label);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 250,
              height: 255,
              child: BarChart(
                mainBarData(),
                swapAnimationDuration: animDuration,
              ),
            )
          ],
        ),
      )
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y,
      {
        bool isTouched = false,
        Color barColor = primaryColor,
        double width = 22,
        List<int> showTooltips = const [],
      }) {

    double maxYValue = 0;

    for (var value in data.values.toList()) {
      if (value > maxYValue)
        maxYValue = value;
    }

    if (maxYValue == 0)
      maxYValue = 100;

    //maxYValue *= 2;

    maxYValue += 1;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: (isTouched ? y + 1 : y),
          colors: isTouched ? [primaryColor.withBlue(255)] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: maxYValue,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(data.keys.length, (i) {
    return makeGroupData(i, data.values.toList()[i], isTouched: i == touchedIndex);
  });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: primaryColor,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay = data.keys.toList()[group.x.toInt()];
              return BarTooltipItem(
                  (weekDay) + '\n' + (rod.y - 1).toString(), TextStyle(color: accentColor));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            return data.keys.toList()[value.toInt()].substring(0, 2);
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}