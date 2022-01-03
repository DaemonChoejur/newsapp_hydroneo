import 'package:hive/hive.dart';
import 'package:news_app_hydroneo/models/article_list.dart';
import 'package:news_app_hydroneo/repository/irepository.dart';

class HiveRepository<T> implements IRepository<T> {
  final Box _box;

  HiveRepository(this._box);

  @override
  Future<T?> get(dynamic id) async {
    if (boxIsClosed) {
      return null;
    }

    return _box.get(id);
  }

  @override
  Future<void> add(T object) async {
    // await _box.clear();
    if (boxIsClosed) {
      return;
    }
    await _box.add(object);
  }

  ArticlesList getArticlesList() {
    var data2 = _box.toMap().values.toList();
    // print(data);
    // print(data2);
    if (data2.isEmpty) return ArticlesList(statusCode: -1, articlesList: []);
    return data2[0];
  }

  bool isNotEmpty() {
    return _box.isNotEmpty;
  }

  bool get boxIsClosed => !_box.isOpen;
}
