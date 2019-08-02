import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/TransactionAmount.dart';
import 'package:farmsmart_flutter/model/model/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/model/mock/MockTransaction.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import '../../MockListRepository.dart';

class MockTransactionRepository extends MockListRepository<TransactionEntity> implements TransactionRepositoryInterface {
  
  MockTransactionRepository._(IdentifyEntity<TransactionEntity> identifyEntity, List<TransactionEntity> startData) : super(identifyEntity: identifyEntity, startingData: startData);

  factory MockTransactionRepository() {
    final identifyEntity = (TransactionEntity transaction) {
      return transaction.id;
    };
    return MockTransactionRepository._(identifyEntity, MockTransaction.list(count: 5));
  }
  
  @override
  Future<List<TransactionEntity>> get(ProfileEntity forProfile) {
    return getList();
  }

  @override
  Stream<List<TransactionEntity>> observeProfile(ProfileEntity forProfile) {
    return observeList();
  }

  @override
  Future<TransactionAmount> allTimeBalance() {
    return getList(update: false).then((transactions){
      return transactions.map((transaction){
        return transaction.amount;
      }).reduce((a,b) {
        return a + b;
      });
    });
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