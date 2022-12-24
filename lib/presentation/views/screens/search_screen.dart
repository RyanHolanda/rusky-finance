import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rusky/data/models/cryptos/cryptos_models.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';
import 'package:rusky/data/models/stocks/brazil/stocks_model.dart';
import 'package:rusky/presentation/widgets/asset_tile/asset_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.isCrypto});

  final bool isCrypto;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void updateList(String value) {
    if (widget.isCrypto == true) {
      setState(() {
        cryptos_display_list = top100Cryptos
            .where((element) => element.name.toLowerCase().contains(value))
            .toList();
      });
    } else {
      setState(() {
        stocks_display_list = brazilStocks
            .where(
                (element) => element.companyName.toLowerCase().contains(value))
            .toList();
      });
    }
  }

  List<CryptoModel> cryptos_display_list = [];
  List<BrazilStocksModel> stocks_display_list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
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
                  borderRadius: BorderRadius.circular(15))),
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: widget.isCrypto
            ? cryptos_display_list.length
            : stocks_display_list.length,
        itemBuilder: (BuildContext context, int index) {
          return AssetTile(
            leading: SizedBox(
                height: 30,
                width: 30,
                child: widget.isCrypto
                    ? Image.network(cryptos_display_list[index].logo,
                        fit: BoxFit.cover)
                    : stocks_display_list[index].logo != ''
                        ? SvgPicture.network(
                            stocks_display_list[index].logo,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox.shrink()),
            title: Text(widget.isCrypto
                ? cryptos_display_list[index].symbol.toUpperCase()
                : stocks_display_list[index].stockSymbol.toUpperCase()),
            subtitle: Text(widget.isCrypto
                ? cryptos_display_list[index].name.toUpperCase()
                : stocks_display_list[index].companyName.toUpperCase()),
          );
        },
      ),
    );
  }
}
