import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';
import 'package:rusky/domain/chart/render_chart.dart';
import 'package:rusky/presentation/blocs/bloc/data_bloc.dart';
import 'package:rusky/presentation/views/loadings/loading_news.dart';
import 'package:rusky/presentation/views/screens/search_screen.dart';
import 'package:rusky/presentation/widgets/asset_chart/asset_chart.dart';
import 'package:rusky/presentation/widgets/news_list/asset_news.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen(
      {super.key,
      this.cryptoId,
      required this.assetSymbol,
      required this.assetPrice,
      required this.assetChange,
      required this.isCrypto,
      required this.assetName});

  final String assetSymbol;
  final String assetName;
  final String? cryptoId;
  final num assetPrice;
  final num assetChange;
  final bool isCrypto;

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  void initState() {
    context.read<DataBloc>().add(DataEventGetAssetsNews(
        assetName: widget.assetName, assetSymbol: widget.assetSymbol));
    context.read<DataBloc>().add(DataEventGetAssetHistoriclPrice(
        isCrypto: widget.isCrypto,
        assetID:
            widget.isCrypto ? widget.cryptoId.toString() : widget.assetSymbol));
    super.initState();
  }

  @override
  void dispose() {
    assetNewsList.clear();
    chartData.clear();
    super.dispose();
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        PageTransition(
                          child: SearchScreen(isCrypto: widget.isCrypto),
                          type: PageTransitionType.bottomToTop,
                        )),
                    icon: const Icon(Icons.search)),
              )
            ],
            title: Text(
              widget.assetSymbol.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.assetName,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Row(
                    children: [
                      Text(
                        'R\$ ${widget.assetPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            color: widget.assetChange < 0
                                ? Colors.red
                                : Colors.green,
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '${widget.assetChange.toStringAsFixed(2)}%',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  state is LoadingData
                      ? const SizedBox(
                          height: 300,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : AssetChart(
                          isCrypto: widget.isCrypto,
                          price: widget.assetPrice,
                          change: widget.assetChange,
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 25),
                    child: Center(
                      child: Text(
                        '${AppLocalizations.of(context)!.newsOf} ${widget.assetName}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  state is DataLoadingNewNews
                      ? const LoadingNews()
                      : AssetNews(scrollController: scrollController),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
