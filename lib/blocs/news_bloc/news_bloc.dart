import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app_hydroneo/api/news_api.dart';
import 'package:news_app_hydroneo/constants.dart';
import 'package:news_app_hydroneo/models/article.dart';
import 'package:news_app_hydroneo/models/article_list.dart';
import 'package:news_app_hydroneo/repository/hive_repository.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsApiClient newsApiClient;
  HiveRepository<ArticlesList> cached;
  late ArticlesList _cachedList;
  // List<Article> _cachedArticleList = [];
  int counter = 0;

  NewsBloc({
    required this.newsApiClient,
    required this.cached,
  }) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      _cachedList = cached.getArticlesList();
      debugPrint(_cachedList.articlesList.length.toString());
      if (event is FetchNews) {
        if (_cachedList.articlesList.isNotEmpty &&
            _cachedList.statusCode != -1) {
          emit(
            NewsLoaded(
              article: _cachedList.articlesList[counter],
            ),
          );
        } else {
          emit(NewsLoading());
          try {
            ArticlesList responseArticleList = await newsApiClient.fetchNews(
                topic: event.topic.name, limit: event.limit);
            _cachedList.articlesList = responseArticleList.articlesList;
            _cachedList = responseArticleList;
            cached.add(responseArticleList);
            emit(NewsLoaded(
              article: _cachedList.articlesList[counter],
            ));
          } catch (e) {
            emit(NewsError(error: e.toString()));
          }
        }
      } else if (event is FetchCachedNextNewsArticle) {
        print("counter $counter");
        print("list ${_cachedList.articlesList.length}");
        if (counter >= _cachedList.articlesList.length) {
          emit(
            NewsLoaded(
              article: _cachedList.articlesList[counter],
            )
              ..hasPreviousArticle = true
              ..hasPreviousArticle = true,
          );
        } else {
          counter++;
          emit(
            NewsLoaded(
              article: _cachedList.articlesList[counter],
            )
              ..hasNextArticle = true
              ..hasPreviousArticle = true,
          );
        }
      } else if (event is FetchCachedPreviousNewsArticle) {
        if (counter <= 0) {
          emit(
            NewsLoaded(
              article: _cachedList.articlesList[counter],
            )..hasNextArticle = true,
          );
        } else {
          counter--;
          emit(
            NewsLoaded(
              article: _cachedList.articlesList[counter],
            )..hasPreviousArticle = true,
          );
        }
      }
    });
  }
}
