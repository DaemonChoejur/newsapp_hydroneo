/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/
abstract class IRepository<T> {
  Future<T?> get(dynamic id);
  Future<void> add(T object);
}
