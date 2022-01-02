import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app_hydroneo/models/article_list.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NewsApiClient {
  final _baseURL = 'https://google-news1.p.rapidapi.com/topic-headlines';

  Dio dio;

  NewsApiClient({required this.dio}) {
    dio.interceptors.add(PrettyDioLogger());

    // 1. can add interceptors for example when http status is 401, we can redirect the user back to the login screen

    // dio.interceptors.add(InterceptorsWrapper(
    //   onError: (e, handler) {
    //     // print(e);
    //     if (e.response != null) {
    //       if (e.response!.statusCode == 429) {
    //         print("got it");
    //       }
    //     }
    //   },
    // ));
  }

  Future<ArticlesList> fetchNews({
    required String topic,
    required int limit,
  }) async {
    final _query = {
      'topic': topic,
      'country': 'US',
      'lang': 'en',
      'limit': limit
    };

    Map<String, String> _headers = {
      'x-rapidapi-host': 'google-news1.p.rapidapi.com',
      'x-rapidapi-key':
          kReleaseMode ? dotenv.get('API_KEY') : dotenv.get('DEV_API_KEY'),
    };

    final response = await dio.get(
      _baseURL,
      queryParameters: _query,
      options: Options(headers: _headers),
    );

    if (response.statusCode != 200) {
      throw Exception('error getting news from $_baseURL');
    }

    final json = response.data;

    return ArticlesList.fromJson(json);
  }
}
