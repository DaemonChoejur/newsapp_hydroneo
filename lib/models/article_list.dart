import 'package:hive/hive.dart';
import 'package:news_app_hydroneo/models/article.dart';
part 'article_list.g.dart';

@HiveType(typeId: 0)
class ArticlesList extends HiveObject {
  @HiveField(0)
  int statusCode;
  @HiveField(1)
  List<Article> articlesList;

  ArticlesList({required this.statusCode, required this.articlesList});

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
}
