import 'package:farmsmart_flutter/model/model/mock/MockFactor.dart';
import 'package:farmsmart_flutter/model/model/mock/MockString.dart';
import 'package:farmsmart_flutter/model/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/MockImageEntity.dart';

import '../ProfileEntity.dart';

class MockProfile {
  ProfileEntity build({String name}) {
    final entity = ProfileEntity(
      mockPlainText.identifier(),
      name ?? _names.random(),
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

  List<ProfileEntity> library() {
    final names = _names.libarary();
    List<ProfileEntity> entities = [];
    for (var name in names) {
        entities.add(build(name: name));
    }
    return entities;
  }

  final _names = MockString(library: [    
    "Harry Lusk",
    "Maribel Dapeton",
    "Emma Hooper",
    "Lee Higgins",
    "David Franquet",
    "Farmer Joe",
  ]);
}
