
import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';

import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';

import 'package:farmsmart_flutter/model/entities/TransactionAmount.dart';

import 'package:farmsmart_flutter/model/entities/TransactionEntity.dart';

import '../TransactionRepositoryInterface.dart';

class TransactionRepositoryFirestore implements TransactionRepositoryInterface {
  @override
  Future<TransactionEntity> add(TransactionEntity transaction) {
    // TODO: implement add
    return null;
  }

  @override
  Future<TransactionAmount> allTimeBalance() {
    // TODO: implement allTimeBalance
    return null;
  }

  @override
  Future<List<TransactionEntity>> get(ProfileEntity forProfile) {
    // TODO: implement get
    return null;
  }

  @override
  Future<List<TransactionEntity>> getCollection(EntityCollection<TransactionEntity> collection) {
    // TODO: implement getCollection
    return null;
  }

  @override
  Future<TransactionEntity> getSingle(String uri) {
    // TODO: implement getSingle
    return null;
  }

  @override
  Stream<TransactionEntity> observeSingle(String uri) {
    // TODO: implement observe
    return null;
  }

  @override
  Stream<List<TransactionEntity>> observeProfile(ProfileEntity forProfile) {
    // TODO: implement observeProfile
    return null;
  }

  @override
  Future<bool> remove(TransactionEntity transaction) {
    // TODO: implement remove
    return null;
  }

  @override
  Future<TransactionAmount> thisWeekCosts() {
    // TODO: implement thisWeekCosts
    return null;
  }

  @override
  Future<TransactionAmount> thisWeekSales() {
    // TODO: implement thisWeekSales
    return null;
  }

}