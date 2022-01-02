import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:news_app_hydroneo/api/news_api.dart';
import 'package:news_app_hydroneo/blocs/news_bloc/news_bloc.dart';
import 'package:news_app_hydroneo/common/theme.dart';
import 'package:news_app_hydroneo/models/article_list.dart';
import 'package:news_app_hydroneo/repository/hive_repository.dart';
import 'package:news_app_hydroneo/ui/home.dart';
import 'package:provider/provider.dart';

class ENewsApp extends StatelessWidget {
  final Box cachedBox;
  const ENewsApp({Key? key, required this.cachedBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) {
          return BlocProvider(
            create: (_) => NewsBloc(
              newsApiClient: NewsApiClient(
                dio: Dio(),
              ),
              cached: HiveRepository<ArticlesList>(cachedBox),
            ),
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
