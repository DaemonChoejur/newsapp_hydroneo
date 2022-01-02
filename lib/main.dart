import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_hydroneo/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app_hydroneo/constants.dart';
import 'package:news_app_hydroneo/models/article.dart';
import 'package:news_app_hydroneo/models/article_list.dart';

// com.alphaNapster.paperNews

late Box favourtiesBox;
Future main() async {
  // hive needs to call native code therefore WidgetsFlutterBinding ensures to have an instance of WidgetBinding
  // which is required to call platform channels to call native code
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticlesListAdapter());
  Hive.registerAdapter(ArticleAdapter());

  // open box for hive
  // getting name from enum of TOPICS located at constants.dart
  Box cachedBox = await Hive.openBox<ArticlesList>(TOPICS.world.name);
  favourtiesBox = await Hive.openBox<ArticlesList>('favourites');

  // load .env file from assets
  await dotenv.load(fileName: "assets/.env");
  runApp(
    ENewsApp(
      cachedBox: cachedBox,
    ),
  );
}
