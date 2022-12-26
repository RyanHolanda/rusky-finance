import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';
import 'package:rusky/data/repos/brazil_repo/stocks_repo.dart';
import 'package:rusky/data/repos/cryptos_repo/cryptos_repo.dart';
import 'package:rusky/data/repos/inflation_repo/brazil_inflation_repo.dart';
import 'package:rusky/data/repos/news_repo/news_repo.dart';
import 'package:rusky/domain/chart/render_chart.dart';
part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(const LoadingData(isAppLoading: false)) {
    on<DataEventGetAllStocks>((event, emit) async {
      emit(const LoadingData(isAppLoading: true));
      final stocks = await GetAllBrazilStocks().getAllBrazilStocks();
      final inflation = await GetBrazilInflation().getBrazillianInflation();
      final cryptos = await CryptosRepo().getCryptos();
      top100Cryptos = cryptos;
      brazilInflation = inflation;
      brazilStocks = stocks;
      emit(const DataLoaded(isAppLoading: false));
    });

    on<DataEventGetAllNewsData>((event, emit) async {
      emit(const DataLoadingNewNews(isAppLoading: false));
      final news = await Newsrepo().getNews();
      allNewsList = news;
      emit(const DataLoadedNewNews(isAppLoading: false));
    });

    on<DataEventGetAssetsNews>((event, emit) async {
      emit(const DataLoadingNewNews(isAppLoading: false));
      final news = await GetAssetNewsrepo(
              assetName: event.assetName, assetSymbol: event.assetSymbol)
          .getNews();
      if (news.isEmpty) {
        final newsWithSymbol = await GetAssetNewsrepo(
                assetSymbol: event.assetSymbol, assetName: '')
            .getNews();
        assetNewsList = newsWithSymbol;
      } else {
        assetNewsList = news;
      }
      emit(const DataLoadedNewNews(isAppLoading: false));
    });

    on<DataEventGetAssetHistoriclPrice>((event, emit) async {
      emit(const LoadingData(isAppLoading: false));
      if (event.isCrypto == true) {
        final historicalPrice =
            await GetHistoricalCryptoPrice(coinId: event.assetID)
                .getPriceHistory();
        crypto1yHistoricPrice = historicalPrice;
        await RenderChart(isCrypto: true).renderChart();
        emit(const DataLoaded(isAppLoading: false));
      } else {
        final historicalPrice =
            await GetHistoricalStocksPrice(symbol: event.assetID)
                .getPriceHistory();
        stock1yHistoricPrice = historicalPrice;
        await RenderChart(isCrypto: false).renderChart();
        emit(const DataLoaded(isAppLoading: false));
      }
    });
  }
}
