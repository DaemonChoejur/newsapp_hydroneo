import 'package:news_app_hydroneo/models/source.dart';

class ArticlesList {
  final List<Article> articlesList;

  ArticlesList({required this.articlesList});

  factory ArticlesList.fromJson(List<dynamic> parsedJson) {
    List<Article> articles = [];

    articles = parsedJson.map((i) => Article.fromJson(i)).toList();

    return ArticlesList(articlesList: articles);
  }
}

class Article {
  Source source;
  String link;
  String publishedDate;
  String description;
  String title;
  String thumbnail;

  Article({
    required this.source,
    required this.link,
    required this.publishedDate,
    required this.description,
    required this.title,
    required this.thumbnail,
  });

  static Article fromJson(Map<String, dynamic> json) {
    return Article(
        source: json['source'],
        link: json['link'],
        publishedDate: json['published_date'],
        description: json['description'],
        title: json['title'],
        thumbnail: json['thumbnail']);
  }
}
