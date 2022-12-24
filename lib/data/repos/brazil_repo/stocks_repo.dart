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
