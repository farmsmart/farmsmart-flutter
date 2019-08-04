
import 'dart:math';

import '../ProfileEntity.dart';

class MockProfile {
  final _random = Random(0);
  
  ProfileEntity build() {
    final entity = ProfileEntity();
    return entity;
  }

  List<ProfileEntity> list({int count = 50}) {
    List<ProfileEntity> entities = [];
    for (var i = 0; i < count; i++) {
      entities.add(build());
    }
    return entities;
  }
}