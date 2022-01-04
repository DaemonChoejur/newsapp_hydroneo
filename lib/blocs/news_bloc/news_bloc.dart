/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app_hydroneo/api/news_image_url_api.dart';
import 'package:news_app_hydroneo/api/news_api.dart';
import 'package:news_app_hydroneo/models/article.dart';
import 'package:news_app_hydroneo/models/article_list.dart';
import 'package:news_app_hydroneo/repository/hive_repository.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsApiClient newsApiClient;
  String currentTopic;
  HiveRepository<ArticlesList> cached;
  ArticlesList _cachedList = ArticlesList(articlesList: []);
  // List<Article> _cachedArticleList = [];
  int counter = 0;

  final NewsImageUrlApiClient _newsImageUrlApiClient = NewsImageUrlApiClient();

  NewsBloc({
    required this.newsApiClient,
    required this.cached,
    required this.currentTopic,
  }) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      bool valDate = false;
      // check if hive has the lastest data by just checking the first article's published date
      ArticlesList? firstVal = await cached.get(0);
      if (firstVal != null) {
        // covert date to readable format
        String publishedDate = firstVal.articlesList.first.publishedDate;
        DateTime storedDate = DateTime.parse(publishedDate);
        DateTime now = DateTime.now();
        String _formattedDate = DateFormat("d MMMM yyyy").format(storedDate);
        String _formattedDateNow = DateFormat("d MMMM yyyy").format(now);
        valDate = storedDate.isBefore(now);

        debugPrint(
            "date stored in db [$_formattedDate] is before current date [$_formattedDateNow] : $valDate");
      }
      // if (_cachedList.articlesList.isEmpty) {
      _cachedList = cached.getArticlesList();
      // }

      if (event is FetchNews) {
        // NewsResponse newsResponse;
        debugPrint("current Topic: $currentTopic");
        debugPrint("fetch now Topic: ${event.topic}");
        if (_cachedList.articlesList.isNotEmpty &&
            valDate == true &&
            currentTopic == event.topic) {
          // if (valDate == false) {
          debugPrint("fetched from HIVE");
          emit(
            NewsLoaded(
              article: _cachedList.articlesList[counter],
            ),
          );
        } else {
          debugPrint("Fetching new news from API");
          emit(NewsLoading());
          try {
            // newsResponse = await newsApiClient.fetchNews(topic: event.topic);
            ArticlesList responseArticleList =
                await newsApiClient.fetchNews(topic: event.topic);

            // caching here
            _cachedList = responseArticleList;
            // extra step to fetch the image url since the Rapid API doesn't provide a thumbnail url
            List<String?> urlList = await _newsImageUrlApiClient
                .getAllImageUrls(responseArticleList.articlesList);

            urlList.asMap().forEach((index, value) {
              if (value != null) {
                _cachedList.updateThumbnail(index, value.toString());
              }
            });

            // save to hive
            cached.add(_cachedList);
            emit(NewsLoaded(
              article: _cachedList.articlesList[counter],
            ));
          } on SocketException {
            emit(NewsError(error: 'No internet connection'));
          } catch (e) {
            // newsResponse.statusCode
            if (e is DioError) {
              // print(e.response!.statusCode);
              emit(NewsErrorApiLimitExceeded());
              emit(NewsLoaded(article: _cachedList.articlesList[counter]));
            } else {
              emit(
                NewsError(error: 'Oops something went wrong'),
              );
            }
          }
        }
      } else if (event is FetchCachedNextNewsArticle) {
        debugPrint("counter $counter");
        debugPrint("list ${_cachedList.articlesList.length}");
        if (counter >= _cachedList.articlesList.length - 1) {
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
