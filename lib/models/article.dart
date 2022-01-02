/*
 {
  "published_date": "2022-01-01T05:26:47+00:00",
  "title": "Pictures of the world ushering in 2022, as omicron weighs on New Year celebrations - CNBC",
  "link": "https://www.cnbc.com/2022/01/01/photos-of-the-world-welcoming-2022-as-omicron-weighs-on-celebrations.html",
  "source": {
      "title": "CNBC",
      "url": "https://www.cnbc.com"
    }
  },
*/

import 'package:hive/hive.dart';

part 'article.g.dart';

@HiveType(typeId: 1)
class Article extends HiveObject {
  // Source source;
  @HiveField(0)
  String link;
  @HiveField(1)
  String publishedDate;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String title;
  @HiveField(4)
  String? thumbnail;

  Article({
    // required this.source,
    required this.link,
    required this.publishedDate,
    this.description,
    required this.title,
    this.thumbnail,
  });

  static Article fromJson(Map<String, dynamic> json) {
    String description = '';
    String thumbnail = '';
    if (json['description'] != null) description = json['description'];
    if (json['thumbnail'] != null) {
      thumbnail = json['thumbnail'];
    }

    return Article(
      // source: json['source'],
      link: json['link'],
      publishedDate: json['published_date'],
      title: json['title'],
      description: description,
      thumbnail: thumbnail,
    );
  }
}
