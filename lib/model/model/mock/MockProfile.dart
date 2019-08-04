import 'package:farmsmart_flutter/model/model/mock/MockFactor.dart';
import 'package:farmsmart_flutter/model/model/mock/MockString.dart';
import 'package:farmsmart_flutter/model/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/MockImageEntity.dart';

import '../ProfileEntity.dart';

class MockProfile {
  ProfileEntity build() {
    final entity = ProfileEntity(
      mockPlainText.identifier(),
      _names.random(),
      MockImageEntity().build().urlProvider,
      MockFactor().build(),
    );
    return entity;
  }

  List<ProfileEntity> list({int count = 50}) {
    List<ProfileEntity> entities = [];
    for (var i = 0; i < count; i++) {
      entities.add(build());
    }
    return entities;
  }

  final _names = MockString(library: [
    "Lee Higgins",
    "Emma Higgins",
    "Bruna Higgins",
  ]);
}
