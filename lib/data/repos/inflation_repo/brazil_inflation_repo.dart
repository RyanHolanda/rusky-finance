import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rusky/data/models/inflation/brazil_inflation_model.dart';

class GetBrazilInflation {
  String url =
      'https://brapi.dev/api/v2/inflation?country=brazil&historical=false&sortBy=date&sortOrder=desc';
  Future<List<BrazilInflationModel>> getBrazillianInflation() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['inflation'];
      return result.map((e) => BrazilInflationModel.fromJson(e)).toList();
    } else {
      Exception(response.reasonPhrase);
      return getBrazillianInflation();
    }
  }
}
