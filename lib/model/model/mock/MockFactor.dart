import 'package:farmsmart_flutter/model/model/FactorEntity.dart';
import 'package:farmsmart_flutter/model/repositories/MockStrings.dart';
import 'MockEntity.dart';

class MockFactor extends MockEntity<FactorEntity> {
  final _values = {
    "Skill Level": 0.4,
    "Locations": 0.3,
    "Agrozone": 0.3,
    "Land Size": 0.6,
    "Soil Type": 0.2,
    "Irrigation": 0.1,
    "Month": 0.9,
    "Intention": 0.8,
  };

  FactorEntity build() {
    return FactorEntity(factors.random(), _values);
  }
}
