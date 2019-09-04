import 'package:farmsmart_flutter/model/entities/TransactionAmount.dart';
import 'package:farmsmart_flutter/model/entities/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockTransaction.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import '../../MockListRepository.dart';

class _Constants {
  static const mockCount = 5;
}

class MockTransactionRepository extends MockListRepository<TransactionEntity>
    implements TransactionRepositoryInterface {
  MockTransactionRepository._(
    ProfileRepositoryInterface profileRepository,
    IdentifyEntity<TransactionEntity> identifyEntity,
    List<TransactionEntity> startData,
  ) : super(
          identifyEntity: identifyEntity,
          startingData: startData,
          
        );

  factory MockTransactionRepository(
      ProfileRepositoryInterface profileRepository) {
    final identifyEntity = (TransactionEntity transaction) {
      return transaction.uri;
    };
    return MockTransactionRepository._(profileRepository, identifyEntity,
        MockTransaction().list(count: _Constants.mockCount));
  }

  @override
  Future<List<TransactionEntity>> get() {
    return getList();
  }

  @override
  Stream<List<TransactionEntity>> stream() {
    return observeList();
  }

  @override
  Future<TransactionAmount> allTimeBalance() {
    return getList(update: false).then((transactions) {
      return transactions.map((transaction) {
        return transaction.amount;
      }).reduce((a, b) {
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
