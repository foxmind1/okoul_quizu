import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:okoul_quizu/services/shared_prefs_services.dart';

class ScoreChart extends StatelessWidget {
  const ScoreChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    var scoreData = SharedPrefsServices().getUserScore;
    double inc = 0;
    List listOfScores = [];

    for (var scoreItem in scoreData) {
      listOfScores.add(jsonDecode(scoreItem));
    }

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 30,
        clipData: FlClipData(top: true, bottom: true, left: true, right: true),
        backgroundColor: theme.colorScheme.tertiary.withOpacity(0.15),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            axisNameWidget: const Text(""),
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: theme.colorScheme.tertiary.withOpacity(0.2),
              strokeWidth: 1,
            );
          },
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              ...listOfScores.map((item) {
                inc++;
                return FlSpot(inc, int.parse(item['score']).toDouble());
              }).toList()
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: [theme.colorScheme.tertiary, theme.colorScheme.secondary],
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.tertiary.withOpacity(0.25),
                  theme.colorScheme.secondary.withOpacity(0.25)
                ],
              ),
            ),
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
