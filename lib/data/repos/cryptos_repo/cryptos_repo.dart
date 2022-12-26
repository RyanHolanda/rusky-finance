import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rusky/data/models/cryptos/cryptos_models.dart';

class CryptosRepo {
  final String url =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=brl&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=24h';

  Future getCryptos() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => CryptoModel.fromJson(e)).toList();
    } else {
      Timer.periodic(const Duration(seconds: 30), (timer) {
        getCryptos();
      });
    }
  }
}

class GetHistoricalCryptoPrice {
  String coinId;
  late final String url =
      'https://api.coingecko.com/api/v3/coins/$coinId/ohlc?vs_currency=brl&days=365';

  GetHistoricalCryptoPrice({required this.coinId});
  Future getPriceHistory() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result;
    } else {
      Timer.periodic(const Duration(seconds: 30), (timer) {
        getPriceHistory();
      });
    }
  }
}
