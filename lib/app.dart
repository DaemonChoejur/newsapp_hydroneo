/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:news_app_hydroneo/api/news_api.dart';
import 'package:news_app_hydroneo/blocs/news_bloc/news_bloc.dart';
import 'package:news_app_hydroneo/common/theme.dart';
import 'package:news_app_hydroneo/models/article_list.dart';
import 'package:news_app_hydroneo/notifiers/article_notifier.dart';
import 'package:news_app_hydroneo/notifiers/topics_notifier.dart';
import 'package:news_app_hydroneo/repository/hive_repository.dart';
import 'package:news_app_hydroneo/ui/home.dart';
import 'package:provider/provider.dart';

class ENewsApp extends StatelessWidget {
  final Box cachedBox;
  final Box favourtiesBox;
  ENewsApp({Key? key, required this.cachedBox, required this.favourtiesBox})
      : super(key: key);

  final BaseOptions options =
      BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);

  @override
  Widget build(BuildContext context) {
    // change notifiers theme and topic notifier provided here
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => TopicsNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => ArticleNotifier(),
        )
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) {
          return MultiBlocProvider(
            providers: [
              // provide bloc for news bloc
              BlocProvider(
                create: (_) => NewsBloc(
                    newsApiClient: NewsApiClient(
                      dio: Dio(options),
                    ),
                    cached: HiveRepository<ArticlesList>(cachedBox),
                    currentTopic:
                        Provider.of<TopicsNotifier>(context).currentTopic),
              ),
            ],
            child: MaterialApp(
              theme: theme.getTheme(),
              debugShowCheckedModeBanner: false,
              home: const Home(),
            ),
          );
        },
      ),
    );
  }
}
