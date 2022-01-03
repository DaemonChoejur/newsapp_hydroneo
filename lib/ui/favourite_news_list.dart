import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:news_app_hydroneo/models/article.dart';
import 'package:news_app_hydroneo/repository/boxes.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/news_thumbnail_widget.dart';

class FavouriteNewsList extends StatelessWidget {
  const FavouriteNewsList({Key? key}) : super(key: key);

  String _convertTime(String date) {
    DateTime dt = DateTime.parse(date);
    String _formattedDate =
        DateFormat("EEEE, d MMMM yyyy, HH:mm:ss").format(dt);
    return _formattedDate;
  }

  // url launcher to launch url
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = Boxes.getArticles();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourties',
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 16.0,
              backgroundColor: Colors.blue,
              child: Text(
                box.values.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ValueListenableBuilder(
          valueListenable: Boxes.getArticles().listenable(),
          builder: (context, Box box, _) {
            final articles = box.values.toList().cast<Article>();
            return articles.isEmpty
                ? Center(
                    child: Container(
                      child: const Text(
                        'No favourties added',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: articles.length,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: InkWell(
                              onTap: () {
                                _launchURL(articles[index].link);
                                // print();
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: NewsThumbnailWidget(
                                            thumbnail: articles[index]
                                                .thumbnail
                                                .toString()),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 8,
                                              child: Text(
                                                articles[index].title,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                // softWrap: true,
                                                maxLines: 5,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Flexible(
                                              flex: 2,
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    const Icon(
                                                      Icons.access_time_rounded,
                                                      color: Colors.blue,
                                                      size: 22,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      _convertTime(
                                                          articles[index]
                                                              .publishedDate),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                            fontSize: 14,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
          }),
    );
  }
}
