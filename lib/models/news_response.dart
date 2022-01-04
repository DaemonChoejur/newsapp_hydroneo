/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/

import 'package:news_app_hydroneo/models/article_list.dart';

class NewsResponse {
  int? statusCode;
  ArticlesList articlesList;

  NewsResponse({this.statusCode, required this.articlesList});
}
