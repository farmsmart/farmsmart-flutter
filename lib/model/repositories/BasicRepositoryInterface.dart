import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';

abstract class BasicRepositoryInterface<T> {
  Future<List<T>> getCollection(EntityCollection<T> collection);
  Future<T> getSingle(String uri);
  Stream<T> observeSingle(String uri);
}
