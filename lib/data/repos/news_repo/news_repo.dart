// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rusky/data/models/news/news_model.dart';

class Newsrepo {
  late String url =
      'https://api.thenewsapi.com/v1/news/top?language=pt&api_token=$_apiKey&categories=business,tech&locale=br&sort=published_at';

  Future<List<NewsModel>> getNews() async {
    final response = await http.get(Uri.parse(url), headers: _setHeaders());
    if (response.statusCode == 200) {
      final List result = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      print('getting news');
      return result.map((e) => NewsModel.fromJson(e)).toList();
    } else {
      print('error news');
      print(response.reasonPhrase);
      return [];
    }
  }
}

class GetAssetNewsrepo {
  String? assetName;
  String assetSymbol;
  GetAssetNewsrepo({
    required this.assetSymbol,
    this.assetName,
  });

  late String url =
      'https://api.thenewsapi.com/v1/news/top?language=pt&api_token=$_apiKey&search=$assetName+$assetSymbol&sort=published_at&categories=business,tech';

  Future getNews() async {
    final response = await http.get(Uri.parse(url), headers: _setHeaders());
    if (response.statusCode == 200) {
      final List result = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      print('getting news');
      return result.map((e) => NewsModel.fromJson(e)).toList();
    } else {
      Timer.periodic(
        Duration(seconds: 30),
        (timer) {
          getNews();
        },
      );
    }
  }
}

_setHeaders() => {'X-API-KEY': _apiKey};
String _apiKey = dotenv.env['NEWS_API_KEY']!;
