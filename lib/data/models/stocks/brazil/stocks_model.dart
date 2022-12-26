// ignore_for_file: public_member_api_docs, sort_constructors_first
class BrazilStocksModel {
  String stockSymbol;
  String companyName;
  num close;
  num change;
  String? sector;
  String logo;
  BrazilStocksModel({
    required this.stockSymbol,
    required this.companyName,
    required this.close,
    required this.change,
    required this.sector,
    required this.logo,
  });

  factory BrazilStocksModel.fromJson(Map<String, dynamic> json) {
    return BrazilStocksModel(
      stockSymbol: json['stock'] ?? '',
      companyName: json['name'] ?? '',
      close: json['close'] ?? 0,
      change: json['change'] ?? 0,
      sector: json['sector'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
}


class BrazilHistoricalStocksPriceModel {
  num close;
  num open;
  num high;
  num low;

  BrazilHistoricalStocksPriceModel({
    required this.close,
    required this.open,
    required this.high,
    required this.low,
  });

  factory BrazilHistoricalStocksPriceModel.fromJson(Map<String, dynamic> json) {
    return BrazilHistoricalStocksPriceModel(
      open: json['open'] ?? 0,
      high: json['high'] ?? 0,
      close: json['close'] ?? 0,
      low: json['low'] ?? 0
    );
  }
}
