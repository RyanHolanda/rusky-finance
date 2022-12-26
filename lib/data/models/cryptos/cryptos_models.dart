// ignore_for_file: public_member_api_docs, sort_constructors_first
class CryptoModel {
  String name;
  String symbol;
  String id;
  String logo;
  num marketCapRank;
  num marketCap;
  num price;
  num priceChange24h;
  num circulatingSupply;
  num totalSupply;
  num maxSupply;
  num athChangePercentage;
  CryptoModel({
    required this.name,
    required this.symbol,
    required this.id,
    required this.logo,
    required this.marketCapRank,
    required this.marketCap,
    required this.price,
    required this.priceChange24h,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.athChangePercentage,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      id: json['id'] ?? '',
      logo: json['image'] ?? '',
      marketCapRank: json['market_cap_rank'],
      marketCap: json['market_cap'] ?? 0,
      price: json['current_price'] ?? 0,
      priceChange24h: json['price_change_percentage_24h'] ?? 0,
      circulatingSupply: json['circulating_supply'] ?? 0,
      totalSupply: json['total_supply'] ?? 0,
      maxSupply: json['max_supply'] ?? 0,
      athChangePercentage: json['ath_change_percentage'] ?? 0,
    );
  }
}