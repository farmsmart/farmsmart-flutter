import 'dart:math';

import 'package:farmsmart_flutter/model/entities/TransactionAmount.dart';
import 'package:farmsmart_flutter/model/entities/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockCrop.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockDate.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';

class MockTransaction {
  final _random = Random(0);
  TransactionEntity build() {
    final entity = TransactionEntity(
      _descriptions.identifier(),
      TransactionAmount(_amounts.random(), _random.nextBool()),
      MockCrop.build().name,
      _descriptions.random(),
      MockDate().randomMonthAgo(),
    );
    return entity;
  }

  List<TransactionEntity> list({int count = 50}) {
    List<TransactionEntity> entities = [];
    for (var i = 0; i < count; i++) {
      entities.add(build());
    }
    return entities;
  }

  final _amounts = MockString(library: [
    "100.23",
    "200",
    "2048",
    "4096",
    "666",
    "24.34",
  ]);

  final _descriptions = MockString(library: [
    "Short",
    "Ideal size description",
    "mid sized desc Lorem ipsum dolor sit amet",
    "Long description Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nibh quam",
    "Very very very Long description Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nibh quam, sodales in sollicitudin ut, scelerisque non sapien. Nam nec mi malesuada libero euismod tincidunt sit amet mattis ipsum. Etiam dapibus sem ac accumsan elementum. Vivamus mattis at diam ac pellentesque. Sed id eros condimentum, dignissim risus id, semper enim. Etiam tempor mauris id lorem fringilla, dapibus feugiat enim placerat. In hac habitasse platea dictumst. Nam est felis, accumsan et sapien ac, molestie convallis sapien. Vivamus ligula sapien, ultrices quis nisl ac, blandit hendrerit massa. Maecenas eleifend, nisi eget commodo mollis, elit magna pellentesque odio, sit amet auctor quam nibh vel purus. Integer ultricies lacinia ipsum, in tincidunt erat finibus eget.",
  ]);
}
