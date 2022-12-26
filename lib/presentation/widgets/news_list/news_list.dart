import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';
import 'package:rusky/presentation/widgets/news_tile/news_tile.dart';

class NewsList extends StatelessWidget {
  const NewsList({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: ListView.builder(
        controller: scrollController,
        itemCount: allNewsList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          var inputFormat = DateFormat('yyy-MM-dd');
          var inputDate =
              inputFormat.parse(allNewsList[index].date.split('T')[0]);
          var outputFormat = DateFormat('dd-MM-yyyy');
          var outputDate = outputFormat.format(inputDate);
          return NewsTile(
            title: allNewsList[index].title,
            imageUrl: allNewsList[index].imageUrl,
            source: '${allNewsList[index].sourceId} $outputDate',
            newsLink: allNewsList[index].link,
          );
        },
      ),
    );
  }
}
