/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/

import 'package:flutter/material.dart';
import 'package:news_app_hydroneo/models/article.dart';

class ArticleNotifier extends ChangeNotifier {
  Article currentArticle = Article(
    link: '',
    publishedDate: '',
    title: '',
  );

  void setCurrentArticle(Article article) {
    if (currentArticle != article) {
      currentArticle = article;
      notifyListeners();
    }
  }
}
