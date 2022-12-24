class BrazilStocksModel {
  String stockSymbol;
  String companyName;
  num close;
  num change;
  String? sector;
  String? logo;
  BrazilStocksModel({
    required this.stockSymbol,
    required this.companyName,
    required this.close,
    required this.change,
    this.sector,
    this.logo,
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
