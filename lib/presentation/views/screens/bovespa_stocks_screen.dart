import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rusky/presentation/views/screens/chart_screen.dart';
import 'package:rusky/presentation/views/screens/search_screen.dart';
import 'package:rusky/presentation/widgets/asset_tile/asset_tile.dart';

class BovespaStocksScreen extends StatefulWidget {
  const BovespaStocksScreen({super.key});

  @override
  State<BovespaStocksScreen> createState() => _BovespaStocksScreenState();
}

class _BovespaStocksScreenState extends State<BovespaStocksScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<String> filterOptions = [
      AppLocalizations.of(context)!.name,
      AppLocalizations.of(context)!.price,
      AppLocalizations.of(context)!.change
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
                splashRadius: 20,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        child: const SearchScreen(isCrypto: false),
                        type: PageTransitionType.bottomToTop,
                      ));
                },
                icon: const Icon(
                  Icons.search,
                )),
          )
        ],
        title: const Text(
          'B3',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: filterOptions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Center(
                        child: TextButton.icon(
                            onPressed: () {
                              setState(() {
                                if (filterOptions[index] ==
                                    AppLocalizations.of(context)!.name) {
                                  brazilStocks.sort(
                                    (a, b) =>
                                        a.stockSymbol.compareTo(b.stockSymbol),
                                  );
                                }
                                if (filterOptions[index] ==
                                    AppLocalizations.of(context)!.price) {
                                  brazilStocks.sort(
                                    (a, b) => b.close.compareTo(a.close),
                                  );
                                }
                                if (filterOptions[index] ==
                                    AppLocalizations.of(context)!.change) {
                                  brazilStocks.sort(
                                    (a, b) => b.change.compareTo(a.change),
                                  );
                                }
                              });
                            },
                            icon: Icon(
                              Icons.short_text,
                              size: 15,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                            ),
                            label: Text(
                              filterOptions[index],
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5)),
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: brazilStocks.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return AssetTile(
                    onPressed: () => Navigator.push(
                        context,
                        PageTransition(
                            child: ChartScreen(
                                assetChange: brazilStocks[index].change,
                                assetPrice: brazilStocks[index].close,
                                assetName: brazilStocks[index].companyName,
                                isCrypto: false,
                                assetSymbol: brazilStocks[index].stockSymbol),
                            type: PageTransitionType.rightToLeftWithFade)),
                    leading: brazilStocks[index].logo != ''
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox(
                                height: 30,
                                width: 30,
                                child: SvgPicture.network(
                                  brazilStocks[index].logo,
                                  fit: BoxFit.cover,
                                )),
                          )
                        : const SizedBox.shrink(),
                    title: Row(
                      children: [
                        Text(
                          brazilStocks[index].stockSymbol,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'R\$ ${brazilStocks[index].close.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    subtitle: Text(
                      brazilStocks[index].companyName,
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: brazilStocks[index].change < 0
                              ? const Color.fromARGB(255, 255, 17, 0)
                                  .withOpacity(0.1)
                              : const Color.fromARGB(255, 0, 255, 8)
                                  .withOpacity(0.15)),
                      child: Text(
                        '${brazilStocks[index].change.toStringAsFixed(1)}%',
                        style: TextStyle(
                            color: brazilStocks[index].change < 0
                                ? const Color.fromARGB(255, 255, 17, 0)
                                    .withOpacity(0.9)
                                : Color.fromARGB(255, 20, 204, 26)
                                    .withOpacity(0.9),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
