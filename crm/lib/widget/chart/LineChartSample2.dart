import 'dart:collection';
import 'dart:html';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';

class LineChartSample2 extends StatefulWidget {
  final Map<int, double> data;
  final String label;

  const LineChartSample2({Key? key,
    required this.data,
    required this.label}) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State(data, label);
}

class _LineChartSample2State extends State<LineChartSample2> {
  final Map<int, double> data;
  final String label;

  List<Color> gradientColors = [
    primaryColor.withAlpha(100),
    primaryColor,
  ];

  bool showAvg = false;
  
  final Map<int, double> fullValue = {};

  _LineChartSample2State(this.data, this.label) {
    final dates = data.keys.toList();
    dates.sort();

    dates.forEach((element) {
      fullValue[element] = 0;
    });

    data.forEach((key, value) {
      final date = key;

      fullValue[date] = fullValue[date]! + value;
    });
  }

  @override
  Widget build(BuildContext context) => Card(
    elevation: 12,
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              label,
              style: TextStyle(
                  fontSize: 18
              )
          ),
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 340,
            child: LineChart(
              mainData(),
            ),
          )
        ],
      ),
    )
  );

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 10,
          getTextStyles: (value) =>
          const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            return value.toInt().toString();
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
           if (value.toInt() == 0)
             return minValue().toString();
           else if (value.toInt() == 1)
             return "";
           else if (value.toInt() == 2)
             return "";
           else
             return maxValue().toString();
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: minDates().toDouble(),
      maxX: maxDates().toDouble(),
      minY: 0.0,
      maxY: 3.0,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
              fullValue.keys.length,
                  (index) => FlSpot(
                      fullValue.keys.toList()[index].toDouble(),
                      (fullValue.values.toList()[index] * 3 / maxValue())
                  )
          ),
          isCurved: false,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  int maxDates() {
    int max = 0;
    for (var value in fullValue.keys) {
      if (value > max)
        max = value;
    }
    return max;
  }

  int minDates() {
    int max = 0;
    if (fullValue.keys.contains(0))
      return max;
    for (var value in fullValue.keys) {
      if (value < max || max == 0)
        max = value;
    }
    return max;
  }

  double maxValue() {
    double max = 0;
    for (var value in fullValue.values) {
      if (value > max)
        max = value;
    }
    return max;
  }

  double minValue() {
    double min = 0;
    int max = 0;
    if (fullValue.keys.contains(0))
      return min;
    for (var value in fullValue.values) {
      if (value < min || min == 0)
        min = value;
    }
    return min;
  }

  int middleValue() {
    double min = 0;
    for (var value in fullValue.values) {
     // if (value < min)
        min += value;
    }
    return min ~/ fullValue.values.length;
  }
}