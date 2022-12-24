// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rusky/data/models/news/news_model.dart';

class Newsrepo {
  String language;
  int page;
  Newsrepo({
    required this.page,
    required this.language,
  });

  late String url =
      'https://newsdata.io/api/1/news?apikey=$_apiKey&language=$language&category=business&page=$page';

  Future<List<NewsModel>> getNews() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['results'];
      return result.map((e) => NewsModel.fromJson(e)).toList();
    } else {
      print('error news');

      return getNews();
    }
  }
}

String _apiKey = dotenv.env['NEWS_API_KEY']!;
