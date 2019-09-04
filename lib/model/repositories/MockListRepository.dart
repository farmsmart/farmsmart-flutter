import 'dart:async';

import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/model/repositories/BasicRepositoryInterface.dart';

typedef String IdentifyEntity<T>(T value);

class MockListRepository<T> implements BasicRepositoryInterface<T> {
  final IdentifyEntity<T> _identFunction;
  final _streamController = StreamController<List<T>>.broadcast();
  List<T> _objects;

  var _observers = Map<String, StreamController<T>>();

  MockListRepository(
      {IdentifyEntity<T> identifyEntity, List<T> startingData = const []})
      : this._identFunction = identifyEntity,
        this._objects = startingData;

  @override
  Future<List<T>> getCollection(EntityCollection<T> collection) {
    return collection.getEntities();
  }

  @override
  Future<T> getSingle(String uri) {
    final entity = _objects.singleWhere(
        (entity) => _identFunction(entity) == uri,
        orElse: () => null);
    return entity != null ? Future.value(entity) : Future.error(Error());
  }

  @override
  Stream<T> observeSingle(String uri) {
    if (_observers[uri] == null) {
      _observers[uri] = StreamController<T>.broadcast();
    }
    return _observers[uri].stream;
  }

  Future<List<T>> getList({bool update = true}) {
    final list = Future.value(_objects);
    if (update) {
      _update();
    }
    return list;
  }

  Stream<List<T>> observeList() {
    return _streamController.stream;
  }

  Future<T> add(T object) {
    _objects.add(object);
    _update();
    return Future<T>.value(object);
  }

  Future<bool> remove(T object) {
    _objects.remove(object);
    _update();
    return Future.value(true);
  }

  Future<T> replace(T oldObject, T newObject) {
    final index = _objects.indexOf(oldObject);
    _objects.replaceRange(index, index + 1, [newObject]);
    _update();
    return Future.value(newObject);
  }

  void _update() {
    _streamController.sink.add(_objects);
    //LH update any observers of the plots
    if (_identFunction != null) {
      for (var object in _objects) {
        final controller = _observers[_identFunction(object)];
        if (controller != null) {
          controller.sink.add(object);
        }
      }
    }
  }

  void dispose() {
    _streamController.sink.close();
    _streamController.close();
    for (var controller in _observers.values) {
      controller.sink.close();
      controller.close();
    }
  }
}
