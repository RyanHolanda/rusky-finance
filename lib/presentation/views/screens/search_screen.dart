import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rusky/data/models/cryptos/cryptos_models.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';
import 'package:rusky/data/models/stocks/brazil/stocks_model.dart';
import 'package:rusky/presentation/views/screens/chart_screen.dart';
import 'package:rusky/presentation/widgets/asset_tile/asset_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.isCrypto});

  final bool isCrypto;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void updateList(String value) {
    if (widget.isCrypto == true) {
      setState(() {
        cryptosDisplayList = top100Cryptos
            .where((element) => element.name.toLowerCase().contains(value))
            .toList();
      });
    } else {
      setState(() {
        stocksDisplayList = brazilStocks
            .where(
                (element) => element.companyName.toLowerCase().contains(value))
            .toList();
      });
    }
  }

  List<CryptoModel> cryptosDisplayList = [];
  List<BrazilStocksModel> stocksDisplayList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: SizedBox(
          height: 60,
          child: TextField(
            onChanged: (value) {
              updateList(value);
            },
            autofocus: true,
            decoration: InputDecoration(
                hintText: widget.isCrypto
                    ? '• Ethereum • Bitcoin • BNB...'
                    : '• Vale • Ambev • OI...',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor.withOpacity(0.2)),
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25))),
          ),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.isCrypto
            ? cryptosDisplayList.length
            : stocksDisplayList.length,
        itemBuilder: (BuildContext context, int index) {
          return AssetTile(
            onPressed: () => Navigator.push(
                context,
                PageTransition(
                    child: ChartScreen(
                        assetSymbol: widget.isCrypto
                            ? cryptosDisplayList[index].symbol
                            : stocksDisplayList[index].stockSymbol,
                        assetPrice: widget.isCrypto
                            ? cryptosDisplayList[index].price
                            : stocksDisplayList[index].close,
                        assetChange: widget.isCrypto
                            ? cryptosDisplayList[index].priceChange24h
                            : stocksDisplayList[index].change,
                        isCrypto: widget.isCrypto ? true : false,
                        assetName: widget.isCrypto
                            ? cryptosDisplayList[index].name
                            : stocksDisplayList[index].companyName),
                    type: PageTransitionType.rightToLeftWithFade)),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: widget.isCrypto
                      ? Image.network(cryptosDisplayList[index].logo,
                          fit: BoxFit.cover)
                      : stocksDisplayList[index].logo != ''
                          ? SvgPicture.network(
                              stocksDisplayList[index].logo,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox.shrink()),
            ),
            title: Text(widget.isCrypto
                ? cryptosDisplayList[index].symbol.toUpperCase()
                : stocksDisplayList[index].stockSymbol.toUpperCase()),
            subtitle: Text(widget.isCrypto
                ? cryptosDisplayList[index].name.toUpperCase()
                : stocksDisplayList[index].companyName.toUpperCase()),
          );
        },
      ),
    );
  }
}
