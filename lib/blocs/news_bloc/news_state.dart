/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/

part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsError extends NewsState {
  final String error;

  NewsError({required this.error});
}

class NewsErrorApiLimitExceeded extends NewsState {}

class NewsLoaded extends NewsState {
  // final ArticlesList articlesList;
  final Article article;
  bool hasNextArticle = false;
  bool hasPreviousArticle = false;

  // hasNextArticle: counter < _cachedList.length ? true : false,
  //       hasPreviousArticle: counter >= 0 ? true : false,

  NewsLoaded({
    required this.article,
  });
}

class NewsLoading extends NewsState {}

class NewsReachedEnd extends NewsState {}
