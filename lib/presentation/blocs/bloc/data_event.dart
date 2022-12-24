// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();
}

class DataEventGetAllNewsData extends DataEvent {
  final int newsPage;
  final String newsLanguage;
  const DataEventGetAllNewsData({
    required this.newsPage,
    required this.newsLanguage,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}

class DataEventGetAllStocks extends DataEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
