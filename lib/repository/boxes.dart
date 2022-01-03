/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_hydroneo/constants.dart';
import 'package:news_app_hydroneo/models/article.dart';

class Boxes {
  static Box<Article> getArticles() => Hive.box<Article>(
        kFavouriteBox,
      );
}
