import 'dart:math';

import 'package:farmsmart_flutter/model/model/TransactionAmount.dart';
import 'package:farmsmart_flutter/model/model/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/model/mock/MockDate.dart';

class MockTransaction {
  static TransactionEntity build() {
    final random = Random();
    final entity = TransactionEntity("",TransactionAmount("100.00",random.nextBool()),"General","description of the thing", MockDate().randomMonthAgo());
    return entity;
  }

  static List<TransactionEntity> list({int count = 50}) {
    List<TransactionEntity> entities = [];
    for (var i = 0; i < count; i++) {
      entities.add(build());
    }
    return entities;
  }
}
