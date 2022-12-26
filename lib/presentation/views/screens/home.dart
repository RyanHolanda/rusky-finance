import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';
import 'package:rusky/presentation/blocs/bloc/data_bloc.dart';
import 'package:rusky/presentation/views/loadings/global_loading.dart';
import 'package:rusky/presentation/views/loadings/loading_news.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rusky/presentation/views/screens/bovespa_stocks_screen.dart';
import 'package:rusky/presentation/views/screens/chart_screen.dart';
import 'package:rusky/presentation/views/screens/cryptos_list_screen.dart';
import 'package:rusky/presentation/widgets/news_list/news_list.dart';
import 'package:rusky/presentation/widgets/stocks_card/stocks_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<DataBloc>().add(DataEventGetAllStocks());
    context.read<DataBloc>().add(DataEventGetAllNewsData());
    super.initState();
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        return state.isAppLoading
            ? const GlobalLoading()
            : Scaffold(
                appBar: AppBar(
                  toolbarHeight: 70,
                  centerTitle: true,
                  title: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.brazilInflationRate,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        brazilInflation.isEmpty
                            ? ''
                            : '~= ${brazilInflation[0].inflationRate} %',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.orange),
                      )
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  child: SafeArea(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            const Text(
                              'B3',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: const BovespaStocksScreen(),
                                          type: PageTransitionType
                                              .rightToLeftWithFade));
                                },
                                child:
                                    Text(AppLocalizations.of(context)!.seeMore))
                          ],
                        ),
                      ),
                      state is LoadingData
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              height: 150,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.only(left: 5, right: 15),
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  return brazilStocks.isEmpty
                                      ? const SizedBox.shrink()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: AssetCard(
                                              onPressed: () => Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child: ChartScreen(
                                                          assetChange:
                                                              brazilStocks[index]
                                                                  .change,
                                                          assetPrice:
                                                              brazilStocks[index]
                                                                  .close,
                                                          assetName:
                                                              brazilStocks[index]
                                                                  .companyName,
                                                          isCrypto: false,
                                                          assetSymbol:
                                                              brazilStocks[index]
                                                                  .stockSymbol),
                                                      type: PageTransitionType
                                                          .rightToLeftWithFade)),
                                              changePercentage:
                                                  brazilStocks[index].change,
                                              name: Text(
                                                brazilStocks[index].companyName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.2)),
                                              ),
                                              price: brazilStocks[index].close,
                                              symbol: Text(brazilStocks[index]
                                                  .stockSymbol)),
                                        );
                                },
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.cryptocurrencies,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: const CryptosScreen(),
                                          type: PageTransitionType
                                              .rightToLeftWithFade));
                                },
                                child:
                                    Text(AppLocalizations.of(context)!.seeMore))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 5, right: 15),
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return top100Cryptos.isEmpty
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: AssetCard(
                                        onPressed: () => Navigator.push(
                                            context,
                                            PageTransition(
                                                child: ChartScreen(
                                                    cryptoId:
                                                        top100Cryptos[index].id,
                                                    assetChange:
                                                        top100Cryptos[index]
                                                            .priceChange24h,
                                                    assetPrice: top100Cryptos[index]
                                                        .price,
                                                    assetName:
                                                        top100Cryptos[index]
                                                            .name,
                                                    isCrypto: true,
                                                    assetSymbol:
                                                        top100Cryptos[index]
                                                            .symbol
                                                            .toUpperCase()),
                                                type: PageTransitionType
                                                    .rightToLeftWithFade)),
                                        changePercentage:
                                            top100Cryptos[index].priceChange24h,
                                        name: Text(
                                          top100Cryptos[index].name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.2)),
                                        ),
                                        price: top100Cryptos[index].price,
                                        symbol: Text(top100Cryptos[index]
                                            .symbol
                                            .toUpperCase())),
                                  );
                          },
                        ),
                      ),
                      allNewsList.isEmpty
                          ? const LoadingNews()
                          : NewsList(scrollController: scrollController),
                    ],
                  )),
                ),
              );
      },
    );
  }
}
