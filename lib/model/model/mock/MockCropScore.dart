import 'package:farmsmart_flutter/model/repositories/MockStrings.dart';

import '../CropScoreEntity.dart';
import 'MockEntity.dart';
import 'MockFactor.dart';

class MockCropScore extends MockEntity<CropScoreEntity> {
   CropScoreEntity build() {
     return CropScoreEntity(plants.random(), MockFactor().list());
  }
}