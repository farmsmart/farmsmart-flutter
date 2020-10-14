import 'package:farmsmart_flutter/model/entities/TransactionAmount.dart';
import 'package:farmsmart_flutter/model/entities/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/repositories/BasicRepositoryInterface.dart';

abstract class TransactionRepositoryInterface implements BasicRepositoryInterface<TransactionEntity> {
    Future<List<TransactionEntity>> get();
    Stream<List<TransactionEntity>> stream();
    Future<TransactionEntity> add(TransactionEntity transaction);
    Future<bool> remove(TransactionEntity transaction);
    Future<TransactionAmount> thisWeekSales();
    Future<TransactionAmount> thisWeekCosts();
    Future<TransactionAmount> allTimeBalance();
}