part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsError extends NewsState {}

class NewsLoaded extends NewsState {
  final ArticlesList articlesList;

  NewsLoaded({required this.articlesList});
}

class NewsLoading extends NewsState {}
