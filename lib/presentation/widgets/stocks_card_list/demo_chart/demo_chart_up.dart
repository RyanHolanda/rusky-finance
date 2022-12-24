import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

SizedBox stockUpDemoChart(BuildContext context) {
  return SizedBox(
    height: 20,
    width: 150,
    child: LineChart(LineChartData(
      minX: 0,
      maxX: 7,
      minY: 0,
      maxY: 6,
      lineTouchData: LineTouchData(enabled: false),
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      lineBarsData: [
        LineChartBarData(
            spots: [
              const FlSpot(0.5, 3.0),
              const FlSpot(1, 7.0),
              const FlSpot(1.5, 3.0),
              const FlSpot(2, 5.0),
              const FlSpot(2.5, 0.0),
              const FlSpot(3, 2.0),
              const FlSpot(3.5, 5.0),
              const FlSpot(4, 0.0),
              const FlSpot(4.5, 4.0),
              const FlSpot(5, 3.0),
              const FlSpot(5.5, 6.0),
            ],
            isCurved: true,
            belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: [
                  Colors.green,
                  Colors.green.withOpacity(0.8),
                  Colors.green.withOpacity(0.8),
                  Colors.green.withOpacity(0.0),
                  Colors.green.withOpacity(0.0),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            color: Colors.green,
            barWidth: 3,
            isStepLineChart: false,
            dotData: FlDotData(show: false))
      ],
    )),
  );
}
