import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_hydroneo/blocs/news_bloc/news_bloc.dart';
import 'package:news_app_hydroneo/constants.dart';
import 'package:news_app_hydroneo/main.dart';
import 'package:news_app_hydroneo/models/article.dart';
import 'package:news_app_hydroneo/ui/components/drawer.dart';
import 'package:news_app_hydroneo/ui/components/news_widget.dart';
import 'package:news_app_hydroneo/ui/favourite_news_list.dart';
import 'package:news_app_hydroneo/ui/topics_bottom_sheet.dart';

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

  Article a = Article(
    // source: Source(favicon: '', title: '', url: ''),
    link:
        'https://nypost.com/2021/07/21/banks-unloads-on-pelosi-vows-to-get-jan-6-answers-via-gop-panel/',
    publishedDate: '2021-07-22T01:15:00+00:00',
    description:
        'Rep. Jim Banks is vowing not to back down from investigating the security shortcomings that led to the attack on the Capitol on Jan. 6 despite Speaker Nancy Pelosi (D-Calif.) booting him from the panel on Wednesday.',
    title:
        'Rep. Jim Banks unloads on Pelosi, vows to get Jan. 6 answers via GOP panel - New York Post',
    thumbnail:
        'https://nypost.com/wp-content/uploads/sites/2/2021/07/jim-banks-914.jpg?quality=80&strip=all&w=1200',
  );

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: InkWell(
          onTap: () {
            // TODO: choose topics
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
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                    TOPICS.world.name.toUpperCase(),
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
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
              HapticFeedback.mediumImpact();
              if (_isBookmarked) {
                // TODO save to favourties

                ScaffoldMessenger.of(context)
                    .showSnackBar(_renderSnackBar('Saved to favourties.'));
              } else {
                // TODO remove from favourties

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
      body: BlocConsumer<NewsBloc, NewsState>(listener: (context, state) {
        if (state is NewsLoaded) {
          // print(state.hasPreviousArticle);
          // print(state.hasNextArticle);
          // if (state.hasNextArticle == false ||
          //     state.hasPreviousArticle == false) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     _renderSnackBar('No more news'),
          //   );
          // }
          // _cached = state.article;

        }
      }, builder: (context, state) {
        if (state is NewsInitial) {
          context
              .read<NewsBloc>()
              .add(FetchNews(topic: TOPICS.world, limit: 30));
        }
        if (state is NewsLoaded) {
          return NewsWidget(
            article: state.article,
          );
        }
        if (state is NewsError) {
          debugPrint(state.error);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
