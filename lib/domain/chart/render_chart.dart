import 'package:fl_chart/fl_chart.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';

List<FlSpot> chartData = [];

class RenderChart {
  bool isCrypto;
  RenderChart({required this.isCrypto});
  Future renderChart() async {
    if (isCrypto == true) {
      for (int i = 0; i < crypto1yHistoricPrice.length; i++) {
        chartData.add(FlSpot(i.toDouble(), crypto1yHistoricPrice[i][4]));
      }
    } else {
      for (int i = 0; i < stock1yHistoricPrice.length; i++) {
        chartData.add(
            FlSpot(i.toDouble(), stock1yHistoricPrice[i].close.toDouble()));
      }
    }
  }
}
