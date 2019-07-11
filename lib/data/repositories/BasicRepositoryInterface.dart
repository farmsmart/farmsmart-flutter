import 'package:farmsmart_flutter/data/model/EntityCollectionInterface.dart';

abstract class BasicRepositoryInterface<T> {
  Future<List<T>> getCollection(EntityCollection<T> collection);
  Future<T> getSingle(String uri);
  Stream<T> observe(String uri);
}
