import 'package:news_app_hydroneo/models/source.dart';

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
}
