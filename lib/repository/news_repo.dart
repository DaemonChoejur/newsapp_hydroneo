import 'package:news_app_hydroneo/api/news_api.dart';
import 'package:news_app_hydroneo/models/article.dart';

class NewsRepository {
  NewsApiClient newsApiClient;

  NewsRepository({required this.newsApiClient});

  Future<ArticlesList> fetchNews({required String topic}) {
    return newsApiClient.fetchNews(topic: topic);
  }
}
