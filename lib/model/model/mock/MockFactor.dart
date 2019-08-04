import 'package:farmsmart_flutter/model/model/FactorEntity.dart';
import 'package:farmsmart_flutter/model/repositories/MockStrings.dart';
import 'MockEntity.dart';

class MockFactor extends MockEntity<FactorEntity> {
  final _values = {
    "Skill Level": 4.0,
    "Locations": 3.0,
    "Agrozone": 3.0,
    "Land Size": 6.0,
    "Soil Type": 2.0,
    "Irrigation": 1.0,
    "Month": 9.0,
    "Intention": 8.0,
  };

  FactorEntity build() {
    return FactorEntity(factors.random(),10.0, _values);
  }
}
