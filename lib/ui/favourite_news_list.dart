/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:news_app_hydroneo/models/article.dart';
import 'package:news_app_hydroneo/repository/boxes.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/news_thumbnail_widget.dart';

class FavouriteNewsList extends StatefulWidget {
  const FavouriteNewsList({Key? key}) : super(key: key);

  @override
  State<FavouriteNewsList> createState() => _FavouriteNewsListState();
}

class _FavouriteNewsListState extends State<FavouriteNewsList> {
  String _convertTime(String date) {
    DateTime dt = DateTime.parse(date);
    String _formattedDate =
        DateFormat("EEEE, d MMMM yyyy\nHH:mm:ss").format(dt);
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
        centerTitle: true,
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
          InkWell(
            onTap: () {
              // clear the list
              HapticFeedback.mediumImpact();
              var box = Boxes.getArticles();
              box.clear();
              setState(() {});
              // _render
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 14.0),
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.red,
              ),
              // height: 10,
              child: const Center(
                child: Text(
                  'Clear',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      // fontSize: 13,
                      ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              radius: 14.0,
              backgroundColor: Colors.blue,
              child: Text(
                box.values.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.8,
                ),
              ),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ValueListenableBuilder(
          valueListenable: Boxes.getArticles().listenable(),
          builder: (context, Box box, _) {
            List<Article> articles = box.values.toList().cast<Article>();
            return articles.isEmpty
                ? const Center(
                    child: SizedBox(
                      child: Text(
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
                                      Expanded(
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
                                              flex: 6,
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
                                            // const SizedBox(height: 10),
                                            Flexible(
                                              flex: 2,
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      Icons.access_time_rounded,
                                                      color: Colors.blue,
                                                      size: 24,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    // Spacer(flex: 1),
                                                    FittedBox(
                                                      fit: BoxFit.fitWidth,
                                                      child: Text(
                                                        _convertTime(
                                                            articles[index]
                                                                .publishedDate),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption!
                                                            .copyWith(
                                                                // fontSize: 13,
                                                                ),
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

// Dissmissable
// key: Key(articles[index].publishedDate),
//                             // Provide a function that tells the app
//                             // what to do after an item has been swiped away.

//                             onDismissed: (direction) {
//                               // remove from hive first
//                               box.delete(articles[index].publishedDate);
//                               // Remove the item from the data source.
//                               setState(() {
//                                 articles.removeAt(index);
//                               });

//                               // Then show a snackbar.
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Article removed'),
//                                 ),
//                               );
//                             },
