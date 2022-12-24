import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';
import 'package:rusky/data/repos/brazil_repo/stocks_repo.dart';
import 'package:rusky/data/repos/inflation_repo/brazil_inflation_repo.dart';
import 'package:rusky/data/repos/news_repo/news_repo.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(const LoadingData(isAppLoading: false)) {
    on<DataEventGetAllStocks>((event, emit) async {
      emit(const LoadingData(isAppLoading: true));
      final stocks = await GetAllBrazilStocks().getAllBrazilStocks();
      final inflation = await GetBrazilInflation().getBrazillianInflation();
      brazilInflation = inflation;
      brazilStocks = stocks;
      emit(const DataLoaded(isAppLoading: false));
    });

    on<DataEventGetAllNewsData>((event, emit) async {
      emit(const DataLoadingNewNews(isAppLoading: false));
      final news =
          await Newsrepo(page: event.newsPage, language: event.newsLanguage)
              .getNews();
      allNewsList = news;
      emit(const DataLoadedNewNews(isAppLoading: false));
    });
  }
}
