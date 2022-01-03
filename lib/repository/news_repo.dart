/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/

import 'package:news_app_hydroneo/api/news_api.dart';
import 'package:news_app_hydroneo/models/article_list.dart';

class NewsRepository {
  NewsApiClient newsApiClient;

  NewsRepository({required this.newsApiClient});

  Future<ArticlesList> fetchNews({required String topic, required int limit}) {
    return newsApiClient.fetchNews(topic: topic, limit: limit);
  }
}
