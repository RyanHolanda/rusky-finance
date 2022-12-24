import 'package:flutter/material.dart';
import 'package:rusky/presentation/widgets/stocks_card_list/demo_chart/demo_chart_down.dart';
import 'package:rusky/presentation/widgets/stocks_card_list/demo_chart/demo_chart_up.dart';

class AssetCard extends StatelessWidget {
  const AssetCard({
    required this.changePercentage,
    required this.name,
    required this.price,
    required this.symbol,
    Key? key,
  }) : super(key: key);

  final Widget symbol;
  final Widget name;
  final num changePercentage;
  final num price;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                blurRadius: 9,
                spreadRadius: 0.5,
                color: Colors.black.withOpacity(0.05)),
          ],
          color: Theme.of(context).cardColor,
        ),
        width: 150,
        height: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: MaterialButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: symbol,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(width: 50, child: name),
                        )
                      ],
                    ),
                  ),
                  changePercentage < 0
                      ? stockDownDemoChart(context)
                      : stockUpDemoChart(context),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          'R\$ ${price.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          '${changePercentage.toStringAsFixed(2)} %',
                          style: TextStyle(
                              color: changePercentage < 0
                                  ? Colors.red
                                  : Colors.green),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
