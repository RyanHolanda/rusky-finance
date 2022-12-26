// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();
}

class DataEventGetAllNewsData extends DataEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DataEventGetAssetsNews extends DataEvent {
  final String assetName;
  final String assetSymbol;
  const DataEventGetAssetsNews({
    required this.assetSymbol,
    required this.assetName,
  });
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DataEventGetAllStocks extends DataEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}


class DataEventGetAssetHistoriclPrice extends DataEvent {
  final String assetID;
  final bool isCrypto;
  const DataEventGetAssetHistoriclPrice({
    required this.isCrypto,
    required this.assetID
  });
  @override
  List<Object?> get props => throw UnimplementedError();
}