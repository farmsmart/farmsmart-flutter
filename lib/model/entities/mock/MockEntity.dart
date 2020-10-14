import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';

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
  final _delay = Duration(milliseconds: 200);
  final MockEntity<T> _builder;
  List<T> _library;
  MockEntityCollection(this._builder);

  @override
  Future<List<T>> getEntities({int limit = 0}) {
    if (_library == null) {
      _library = (limit <= 0) ? _builder.list() : _builder.list(count: limit);
    }
    return Future.delayed(_delay, () => _library);
  }
}
