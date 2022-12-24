part of 'data_bloc.dart';

abstract class DataState extends Equatable {
  final bool isAppLoading;
  const DataState({required this.isAppLoading});

  @override
  List<Object> get props => [];
}

class DataError extends DataState {
  const DataError({required super.isAppLoading});
}

class LoadingData extends DataState {
  const LoadingData({required super.isAppLoading});
}

class DataLoaded extends DataState {
  const DataLoaded({required super.isAppLoading});
}

class DataLoadingNewNews extends DataState {
  const DataLoadingNewNews({required super.isAppLoading});
}

class DataLoadedNewNews extends DataState {
  const DataLoadedNewNews({required super.isAppLoading});
}
