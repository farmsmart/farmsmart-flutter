import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/repositories/BasicRepositoryInterface.dart';

enum CropCollectionGroup {
  all
}

abstract class CropRepositoryInterface implements BasicRepositoryInterface<CropEntity> {
     Future<List<CropEntity>> get({CropCollectionGroup group = CropCollectionGroup.all, int limit = 0});
}