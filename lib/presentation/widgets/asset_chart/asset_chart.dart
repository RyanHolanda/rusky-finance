import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';
import 'package:rusky/domain/chart/render_chart.dart';

class AssetChart extends StatelessWidget {
  const AssetChart({
    required this.change,
    required this.price,
    required this.isCrypto,
    Key? key,
  }) : super(key: key);

  final bool isCrypto;
  final num price;
  final num change;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: LineChart(LineChartData(
          lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              print(stock1yHistoricPrice[touchedSpots.first.spotIndex].close);
              return [
                LineTooltipItem(
                    isCrypto
                        ? 'R\$ ${crypto1yHistoricPrice[touchedSpots.first.spotIndex][4].toStringAsFixed(3)}'
                        : 'R\$ ${stock1yHistoricPrice[touchedSpots.first.spotIndex].close.toStringAsFixed(3)}',
                    TextStyle())
              ];
            },
            tooltipBgColor: Theme.of(context).primaryColor.withOpacity(0.2),
            showOnTopOfTheChartBoxArea: true,
            fitInsideHorizontally: true,
            fitInsideVertically: true,
          )),
          maxX: isCrypto
              ? crypto1yHistoricPrice.length.toDouble()
              : stock1yHistoricPrice.length.toDouble(),
          maxY: isCrypto
              ? crypto1yHistoricPrice.isEmpty
                  ? 0
                  : crypto1yHistoricPrice.first[1]
              : stock1yHistoricPrice.isEmpty
                  ? 0
                  : stock1yHistoricPrice.first.high * 1.4,
          minX: 0,
          minY: 0,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(),
            leftTitles: AxisTitles(),
            rightTitles: AxisTitles(),
            topTitles: AxisTitles(),
          ),
          lineBarsData: [
            LineChartBarData(
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: [
                  change < 0 ? Colors.red : Colors.green,
                  change < 0
                      ? Colors.red.withOpacity(0.9)
                      : Colors.green.withOpacity(0.9),
                  change < 0
                      ? Colors.red.withOpacity(0.5)
                      : Colors.green.withOpacity(0.5),
                  change < 0
                      ? Colors.red.withOpacity(0.3)
                      : Colors.green.withOpacity(0.3),
                  change < 0
                      ? Colors.red.withOpacity(0.2)
                      : Colors.green.withOpacity(0.2),
                  change < 0
                      ? Colors.red.withOpacity(0.0)
                      : Colors.green.withOpacity(0.0),
                  change < 0
                      ? Colors.red.withOpacity(0.0)
                      : Colors.green.withOpacity(0.0),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              dotData: FlDotData(show: false),
              color: change < 0 ? Colors.red : Colors.green,
              isCurved: false,
              spots: chartData,
            )
          ])),
    );
  }
}
