class BrazilInflationModel {
  String inflationRate;
  BrazilInflationModel({
    required this.inflationRate,
  });

  factory BrazilInflationModel.fromJson(Map<String, dynamic> json) {
    return BrazilInflationModel(
      inflationRate: json['value'] ?? '',
    );
  }
}
