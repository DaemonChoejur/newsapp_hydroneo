import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_hydroneo/api/news_api.dart';
import 'package:news_app_hydroneo/blocs/news_bloc/news_bloc.dart';
import 'package:news_app_hydroneo/constants.dart';
import 'package:news_app_hydroneo/models/article.dart';
import 'package:news_app_hydroneo/models/article_list.dart';
import 'package:news_app_hydroneo/repository/hive_repository.dart';

class MockNewsApiClient extends Mock implements NewsApiClient {}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

class MockHiveRepository extends Mock implements HiveRepository<ArticlesList> {
  final MockHiveBox box;

  MockHiveRepository({required this.box});

  @override
  Future<ArticlesList?> get(id) async {
    if (boxIsClosed) {
      return null;
    }

    return box.get(id);
  }

  @override
  Future<void> add(ArticlesList object) async {
    if (boxIsClosed) {
      return;
    }
    await box.add(object);
  }

  @override
  ArticlesList getArticlesList() {
    var data = box.toMap().values.toList();

    if (data.isEmpty) return ArticlesList(statusCode: -1, articlesList: []);
    return data[0];
  }

  @override
  bool isNotEmpty() {
    return box.isNotEmpty;
  }

  @override
  bool get boxIsClosed => !box.isOpen;
}

void main() async {
  late NewsBloc newsBloc;
  late MockNewsApiClient mockNewsApiClient;
  MockHiveInterface mockHiveInterface = MockHiveInterface();

  MockHiveBox mockHiveBox = await mockHiveInterface
      .openBox<ArticlesList>(kFavouriteBox) as MockHiveBox;

  late MockHiveRepository mockHiveRepository;

  setUp(() {
    mockNewsApiClient = MockNewsApiClient();
    // mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockHiveBox();
    mockHiveRepository = MockHiveRepository(box: mockHiveBox);
    newsBloc = NewsBloc(
        newsApiClient: mockNewsApiClient,
        cached: mockHiveRepository,
        currentTopic: TOPICS.world.name);
    // when(() => mockHiveInterface.openBox(kFavouriteBox));
  });

  tearDown(() {
    newsBloc.close();
  });

  group('News Bloc', () {
    //  when(mockHiveRepository.box).thenAnswer((_) async => Future.value());

    blocTest<NewsBloc, NewsState>(
      'emits [NewsInitial] state for initial load',
      build: () => newsBloc,
      act: (newsBloc) => newsBloc,
    );
    blocTest<NewsBloc, NewsState>(
        'emits [NewsLoading, NewsLoaded] states for successful news load',
        setUp: () {
          // when(mockHiveInterface.openBox(name));
        },
        build: () => newsBloc,
        act: (newsBloc) => newsBloc.add(FetchNews(topic: TOPICS.world.name)),
        expect: () => [
              NewsLoading(),
              NewsLoaded(
                article: Article(
                  link: 'link',
                  publishedDate: 'date',
                  title: 'title',
                ),
              )
            ]);
  });
}
