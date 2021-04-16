import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/widget/chart/Indicator.dart';

class PieChartSample2 extends StatefulWidget {
  final String label;
  final Map<MapEntry<String, Color>, double> data;

  const PieChartSample2({Key? key, required this.label, required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State(label, data);
}

class PieChart2State extends State {
  final String label;
  final Map<MapEntry<String, Color>, double> data;

  double totalValue = 0;

  int? touchedIndex;

  PieChart2State(this.label, this.data) {
    for (var value in data.values.toList()) {
      totalValue += value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 250
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Wrap(
                spacing: 35,
                runSpacing: 25,
                children: [
                  SizedBox(
                    width: 175,
                    height: 175,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                            pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex = pieTouchResponse.touchedSectionIndex;
                                }
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 25,
                            sections: showingSections()),
                      ),
                    ),
                  ),
                  dataList()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(data.values.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 24 : 16;
      final double radius = isTouched ? 75 : 65;

      final key = data.keys.toList()[i];
      final value = data.values.toList()[i];

      int procent = value * 100 ~/ totalValue;

      if (procent == 0)
        procent = 1;

      return PieChartSectionData(
        color: key.value,
        value: value,
        title: '$procent%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      );
    });
  }

  dataList() => Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(data.keys.length,
            (index) {
              final key = data.keys.toList()[index];
              final value = data.values.toList()[index];
              return Indicator(
                color: key.value,
                text: "${key.key} - $value",
                isSquare: true,
              );
            }),
  );
}