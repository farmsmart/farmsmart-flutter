import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/entities/TransactionAmount.dart';
import 'package:farmsmart_flutter/model/entities/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/repositories/BasicRepositoryInterface.dart';

abstract class TransactionRepositoryInterface implements BasicRepositoryInterface<TransactionEntity> {
    Future<List<TransactionEntity>> get(ProfileEntity forProfile);
    Stream<List<TransactionEntity>> observeProfile(ProfileEntity forProfile);
    Future<TransactionEntity> add(TransactionEntity transaction);
    Future<bool> remove(TransactionEntity transaction);
    Future<TransactionAmount> thisWeekSales();
    Future<TransactionAmount> thisWeekCosts();
    Future<TransactionAmount> allTimeBalance();
}