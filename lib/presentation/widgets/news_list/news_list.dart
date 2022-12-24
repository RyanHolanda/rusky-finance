import 'package:flutter/material.dart';
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
          return Column(
            children: [
              MaterialButton(
                onPressed: () async {
                  final url = allNewsList[index].link;
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url),
                        mode: LaunchMode.externalApplication);
                  }
                },
                child: ListTile(
                  subtitle: Text(
                    '• ${allNewsList[index].sourceId.replaceFirst(allNewsList[index].sourceId[0], allNewsList[index].sourceId[0].toUpperCase())}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  trailing: allNewsList[index].imageUrl != ''
                      ? SizedBox(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              allNewsList[index].imageUrl,
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
                          allNewsList[index].title,
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
        },
      ),
    );
  }
}
