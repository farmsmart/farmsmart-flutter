import 'package:farmsmart_flutter/data/model/EntityCollectionInterface.dart';

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

class MockEntityCollection<T> implements EntityCollection<T> {
  final _delay = Duration(seconds: 1);
  final MockEntity<T> _builder;

  MockEntityCollection(this._builder);

  @override
  Future<List<T>> getEntities({int limit = 0}) {
    return Future.delayed(_delay, () => _builder.list());
  }
}
