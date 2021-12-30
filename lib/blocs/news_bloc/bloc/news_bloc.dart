import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app_hydroneo/api/news_api.dart';
import 'package:news_app_hydroneo/models/article.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsApiClient newsApiClient;

  NewsBloc({required this.newsApiClient}) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is FetchNews) {
        emit(NewsLoading());
        ArticlesList responseArticleList =
            await newsApiClient.fetchNews(topic: event.topic);

        // TODO: after news fetch cache

        if (responseArticleList.articlesList.isEmpty) emit(NewsError());
        emit(NewsLoaded(articlesList: responseArticleList));
      }
    });
  }
}
