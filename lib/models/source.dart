// We dont really need this data class for now
class Source {
  String title;
  String url;
  String? favicon;

  Source({
    required this.title,
    required this.url,
    this.favicon,
  });

  static Source fromJson(Map<String, dynamic> json) {
    return Source(
      title: json['title'],
      url: json['url'],
      favicon: json['favicon'],
    );
  }
}
