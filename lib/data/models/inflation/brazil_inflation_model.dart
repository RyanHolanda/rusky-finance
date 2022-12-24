// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BrazilInflationModel {
  String inflationRate;
  BrazilInflationModel({
    required this.inflationRate,
  });

  factory BrazilInflationModel.fromJson(Map<String, dynamic> json) {
    return BrazilInflationModel(
      inflationRate: json['value'] as String,
    );
  }
}
