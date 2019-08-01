import 'package:farmsmart_flutter/model/model/TransactionAmount.dart';
import 'package:farmsmart_flutter/model/model/TransactionEntity.dart';

class MockTransaction {
  static TransactionEntity build() {
    final entity = TransactionEntity("",TransactionAmount("100.00"),"General","description of the thing");
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
