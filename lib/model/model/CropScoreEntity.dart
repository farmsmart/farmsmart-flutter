import 'package:farmsmart_flutter/model/model/FactorEntity.dart';

class CropScoreEntity {
    final String name;
    final List<FactorEntity> factors;
    
    CropScoreEntity(this.name, this.factors);
}