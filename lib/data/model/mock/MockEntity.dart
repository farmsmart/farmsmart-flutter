abstract class MockEntity<T> {
  T build();
  List<T> list({int count = 50}) {
    List<T> entities = [];
    for (var i = 0; i < count; i++) {
      entities.add(build());
    }
    return entities;
  }
}
