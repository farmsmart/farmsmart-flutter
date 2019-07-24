import 'package:farmsmart_flutter/data/model/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/mock/MockCrop.dart';
import 'package:farmsmart_flutter/data/repositories/crop/CropRepositoryInterface.dart';


class MockCropRepository implements CropRepositoryInterface {

  final _list = MockCrop.list();
  final _delay = Duration(seconds: 1);
  final _streamEventCount = 50;

  @override
  Future<List<CropEntity>> getCollection(EntityCollection<CropEntity> collection) {
    return collection.getEntities();
  }

  @override
  Future<CropEntity> getSingle(String uri) {
    final result =  _list.reduce((left, right) {
        return (left.id == uri) ? left : (right.id == uri) ? right : null;
    });
    return Future.delayed(_delay, () => result);
  }

  @override
  Stream<CropEntity> observe(String uri) {
    var sequence;
    for (var i = 0; i < _streamEventCount; i++) {
      sequence.add(Future.delayed(_delay, () => MockCrop.build()));
    }
    return Stream.fromFutures(sequence);
  }

  @override
  Future<List<CropEntity>> get({CropCollectionGroup group = CropCollectionGroup.all, int limit = 0}) {
    return  Future.delayed(_delay, () => _list);
  }

}