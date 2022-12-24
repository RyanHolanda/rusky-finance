import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';

import 'package:rusky/presentation/blocs/bloc/data_bloc.dart';
import 'package:rusky/presentation/views/loadings/global_loading.dart';
import 'package:rusky/presentation/views/loadings/loading_news.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rusky/presentation/widgets/news_list/news_list.dart';
import 'package:rusky/presentation/widgets/stocks_card_list/stocks_card_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<DataBloc>().add(DataEventGetAllStocks());
    context
        .read<DataBloc>()
        .add(const DataEventGetAllNewsData(newsPage: 1, newsLanguage: 'pt'));
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
                              'BOVESPA',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: () {},
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
                            return brazilStocks.isEmpty
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: AssetCard(
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
                                        symbol: Text(
                                            brazilStocks[index].stockSymbol)),
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
                                onPressed: () {},
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
                            return brazilStocks.isEmpty
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: AssetCard(
                                        changePercentage: 0,
                                        name: Text(
                                          'Bitcoin',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.2)),
                                        ),
                                        price: 0,
                                        symbol: const Text('BTC')),
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
