part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class FetchNews extends NewsEvent {
  final String topic;
  // final int limit;

  FetchNews({required this.topic});
}

class FetchCachedNextNewsArticle extends NewsEvent {
  FetchCachedNextNewsArticle();
}

class FetchCachedPreviousNewsArticle extends NewsEvent {
  FetchCachedPreviousNewsArticle();
}

//  final Article article;
//   final bool hasNextArticle;
//   final bool hasPreviousArticle;
//   {
//     required this.article,
//     required this.hasNextArticle,
//     required this.hasPreviousArticle,
//   }
