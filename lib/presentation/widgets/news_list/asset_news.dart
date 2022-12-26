import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';
import 'package:rusky/presentation/widgets/news_tile/news_tile.dart';

class AssetNews extends StatelessWidget {
  const AssetNews({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      shrinkWrap: true,
      itemCount: assetNewsList.length,
      itemBuilder: (BuildContext context, int index) {
        var inputFormat = DateFormat('yyy-MM-dd');
        var inputDate =
            inputFormat.parse(assetNewsList[index].date.split('T')[0]);
        var outputFormat = DateFormat('dd-MM-yyyy');
        var outputDate = outputFormat.format(inputDate);
        return NewsTile(
            title: assetNewsList[index].title,
            source: '${assetNewsList[index].sourceId} $outputDate',
            newsLink: assetNewsList[index].link,
            imageUrl: assetNewsList[index].imageUrl);
      },
    );
  }
}
