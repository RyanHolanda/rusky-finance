import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rusky/data/models/stocks/brazil/stocks_model.dart';

class GetAllBrazilStocks {
  String url = 'https://brapi.dev/api/quote/list?sortBy=volume&sortOrder=desc';
  Future<List<BrazilStocksModel>> getAllBrazilStocks() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['stocks'];
      return result.map((e) => BrazilStocksModel.fromJson(e)).toList();
    } else {
      print('error Brazil');

      return getAllBrazilStocks();
    }
  }
}


class GetHistoricalStocksPrice {
  String symbol;
    late String url = 'https://brapi.dev/api/quote/$symbol?range=1y&interval=1d&fundamental=false';
    GetHistoricalStocksPrice({required this.symbol});

  Future getPriceHistory() async {
    final respose = await http.get(Uri.parse(url));
    if(respose.statusCode == 200){
      final List result = jsonDecode(respose.body)['results'][0]['historicalDataPrice'];
      return result.map((e) => BrazilHistoricalStocksPriceModel.fromJson(e)).toList();
    } else {
      print(respose.reasonPhrase);
      Timer.periodic(const Duration(seconds: 30), (timer) {
        getPriceHistory();
      },);
    } 
  }
}
