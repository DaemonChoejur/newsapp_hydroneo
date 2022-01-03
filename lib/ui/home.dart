/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_hydroneo/blocs/news_bloc/news_bloc.dart';
import 'package:news_app_hydroneo/constants.dart';
import 'package:news_app_hydroneo/notifiers/topics_notifier.dart';
import 'package:news_app_hydroneo/repository/boxes.dart';
import 'package:news_app_hydroneo/ui/components/drawer.dart';
import 'package:news_app_hydroneo/ui/components/news_widget.dart';
import 'package:news_app_hydroneo/ui/favourite_news_list.dart';
import 'package:news_app_hydroneo/ui/topics_bottom_sheet.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // animation controller for animated icon
  // late AnimationController _animationController;
  // bool _isPlaying = false;

  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 450),
    // );
  }

  _renderSnackBar(String text) {
    return SnackBar(
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.all(20),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsBloc, NewsState>(listener: (context, state) {
      if (state is NewsLoaded) {
        // check if article in favourties
        final article = Boxes.getArticles();
        if (article.containsKey(state.article.publishedDate)) {
          debugPrint('article is in favrouties');
          setState(() {
            _isBookmarked = true;
          });
        } else {
          setState(() {
            _isBookmarked = false;
          });
        }
      }
    }, builder: (context, state) {
      if (state is NewsInitial) {
        context.read<NewsBloc>().add(
              FetchNews(
                topic: Provider.of<TopicsNotifier>(context, listen: false)
                    .currentTopic,
              ),
            );
      }
      if (state is NewsError) {
        debugPrint(state.error);
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              state.error,
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 30,
                      blurStyle: BlurStyle.solid,
                      color: Colors.blue,
                    ),
                  ]),
              child: Center(
                child: IconButton(
                  alignment: Alignment.center,
                  onPressed: () {
                    // allow manual refresh
                    // TODO refresh
                    context.read<NewsBloc>().add(
                          FetchNews(topic: TOPICS.world.name),
                        );
                  },
                  icon: const Icon(
                    Icons.refresh,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ));
      }
      if (state is NewsLoaded) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          drawer: const NavDrawer(),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: const BoxDecoration(
                        // color: Colors.white,
                        color: Colors.white12,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: const TopicsBottomSheet(),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 10.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Provider.of<TopicsNotifier>(context).currentTopic,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      )
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavouriteNewsList(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.filter_list,
                  size: 26,
                ),
              ),
              IconButton(
                onPressed: () {
                  final box = Boxes.getArticles();
                  setState(() {
                    _isBookmarked = !_isBookmarked;
                  });
                  HapticFeedback.mediumImpact();
                  if (_isBookmarked) {
                    // get the hive box

                    // add current article to hive box
                    // print(state.article.publishedDate);
                    box.put(state.article.publishedDate, state.article);
                    // show user article added
                    ScaffoldMessenger.of(context)
                        .showSnackBar(_renderSnackBar('Saved to favourties.'));
                  } else {
                    //  remove from favourties
                    // using the published date as key
                    box.delete(state.article.publishedDate);
                    ScaffoldMessenger.of(context).showSnackBar(
                      _renderSnackBar('Removed from favourties.'),
                    );
                  }
                },
                icon: _isBookmarked
                    ? const Icon(
                        Icons.bookmark_rounded,
                        color: Colors.red,
                        size: 26,
                      )
                    : const Icon(
                        Icons.bookmark_border_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
              ),
              // ),
            ],
          ),
          // using BlocConsumer since its a combination of BlocListener and BlocBuilder
          body: NewsWidget(
            article: state.article,
          ),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

// BlocBuilder<NewsBloc, NewsState>(
//           // listener: (context, state) {},
//           builder: (context, state) {
//         if (state is NewsInitial) {
//           context.read<NewsBloc>().add(
//                 FetchNews(
//                   topic: Provider.of<TopicsNotifier>(context, listen: false)
//                       .currentTopic,
//                 ),
//               );
//         }
//         if (state is NewsLoaded) {
//           return NewsWidget(
//             article: state.article,
//           );
//         }
//         if (state is NewsError) {
//           debugPrint(state.error);
//           return Center(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 state.error,
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25.0),
//                     color: Colors.blue,
//                     boxShadow: const [
//                       BoxShadow(
//                         blurRadius: 30,
//                         blurStyle: BlurStyle.solid,
//                         color: Colors.blue,
//                       ),
//                     ]),
//                 child: Center(
//                   child: IconButton(
//                     alignment: Alignment.center,
//                     onPressed: () {
//                       // TODO refresh
//                       // context
//                       //     .read<NewsBloc>()
//                       //     .add(FetchNews(topic: TOPICS.world, limit: 10));
//                     },
//                     icon: const Icon(
//                       Icons.refresh,
//                       size: 28,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ));
//         }
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }),
