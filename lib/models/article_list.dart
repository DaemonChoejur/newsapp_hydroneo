/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app_hydroneo/models/article.dart';
part 'article_list.g.dart';

@HiveType(typeId: 0)
class ArticlesList extends HiveObject {
  @HiveField(0)
  int? statusCode;
  @HiveField(1)
  List<Article> articlesList;

  ArticlesList({this.statusCode, required this.articlesList});

  static ArticlesList fromJson(Map<String, dynamic> json) {
    List<Article> articles = [];
    if (json['articles'] != null) {
      json['articles'].forEach((v) {
        articles.add(Article.fromJson(v));
      });
    }
    return ArticlesList(
      statusCode: json['statusCode'],
      articlesList: articles,
    );
  }

  // custom function - update thumbnail url
  void updateThumbnail(int index, String url) {
    articlesList[index].updateThumbnail(url);
    debugPrint("got url $url, updated!!");
  }
}
