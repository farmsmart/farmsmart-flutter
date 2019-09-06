import 'dart:math';

import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/model/entities/crop_entity.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockCrop.dart';
import 'package:farmsmart_flutter/model/repositories/crop/CropRepositoryInterface.dart';


class MockCropRepository implements CropRepositoryInterface {
  final _rand = Random(0);
  final _list = MockCrop.uniqueList();
  final _delay = Duration(milliseconds: 200);
  final _streamEventCount = 50;
  final _errorOneIn = 100;

  @override
  Future<List<CropEntity>> getCollection(EntityCollection<CropEntity> collection) {
    return collection.getEntities();
  }

  @override
  Future<CropEntity> getSingle(String uri) {
    final result =  _list.reduce((left, right) {
        return (left.uri == uri) ? left : (right.uri == uri) ? right : null;
    });
    return Future.delayed(_delay, () => result);
  }

  @override
  Stream<CropEntity> observeSingle(String uri) {
    var sequence;
    for (var i = 0; i < _streamEventCount; i++) {
      sequence.add(Future.delayed(_delay, () => MockCrop.build()));
    }
    return Stream.fromFutures(sequence);
  }

  @override
  Future<List<CropEntity>> get({CropCollectionGroup group = CropCollectionGroup.all, int limit = 0}) {
    int errorChance = _rand.nextInt(_errorOneIn);
    return (errorChance == 1) ? Future.error(Error()) : Future.delayed(_delay, () => _list);
  }

}