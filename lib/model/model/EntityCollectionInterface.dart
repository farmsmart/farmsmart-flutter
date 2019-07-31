abstract class EntityCollection<T> {
  Future<List<T>> getEntities({int limit = 0});
} 