import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rusky/data/models/models_lists/models_lists.dart';
import 'package:url_launcher/url_launcher.dart';

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

class NewsTile extends StatelessWidget {
  const NewsTile({
    required this.title,
    required this.source,
    required this.newsLink,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final String newsLink;
  final String source;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () async {
            final url = newsLink;
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url),
                  mode: LaunchMode.externalApplication);
            }
          },
          child: ListTile(
            subtitle: Text(
              '• $source',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            trailing: imageUrl != ''
                ? SizedBox(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/news_image.jpg',
                          fit: BoxFit.cover,
                        )),
                  ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 70,
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(),
        ),
      ],
    );
  }
}
