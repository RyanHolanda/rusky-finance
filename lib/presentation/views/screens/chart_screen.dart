import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';
import 'package:rusky/presentation/blocs/bloc/data_bloc.dart';
import 'package:rusky/presentation/views/loadings/loading_news.dart';
import 'package:rusky/presentation/views/screens/search_screen.dart';
import 'package:rusky/presentation/widgets/news_list/news_list.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen(
      {super.key,
      required this.assetSymbol,
      required this.assetPrice,
      required this.assetChange,
      required this.isCrypto,
      required this.assetName});

  final String assetSymbol;
  final String assetName;
  final num assetPrice;
  final num assetChange;
  final bool isCrypto;

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  void initState() {
    print('vtnc');
    context.read<DataBloc>().add(DataEventGetAssetsNews(
        assetName: widget.assetName, assetSymbol: widget.assetSymbol));
    super.initState();
  }

  @override
  void dispose() {
    assetNewsList.clear();
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
            physics: BouncingScrollPhysics(),
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.assetName,
                    style: TextStyle(fontSize: 20),
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
                  const SizedBox(
                    height: 300,
                  ),
                  Center(
                    child: Text(
                      '${AppLocalizations.of(context)!.newsOf} ${widget.assetName}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  state is DataLoadingNewNews
                      ? const LoadingNews()
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount: assetNewsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var inputFormat = DateFormat('yyy-MM-dd');
                            var inputDate = inputFormat
                                .parse(assetNewsList[index].date.split('T')[0]);
                            var outputFormat = DateFormat('dd-MM-yyyy');
                            var outputDate = outputFormat.format(inputDate);
                            return NewsTile(
                                title: assetNewsList[index].title,
                                source:
                                    '${assetNewsList[index].sourceId} $outputDate',
                                newsLink: assetNewsList[index].link,
                                imageUrl: assetNewsList[index].imageUrl);
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
