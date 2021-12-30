part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class FetchNews extends NewsEvent {
  final String topic;

  FetchNews({required this.topic});
}
