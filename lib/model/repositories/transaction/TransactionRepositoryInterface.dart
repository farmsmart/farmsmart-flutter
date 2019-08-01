import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/repositories/BasicRepositoryInterface.dart';

abstract class TransactionRepositoryInterface implements BasicRepositoryInterface<TransactionEntity> {
    Future<List<TransactionEntity>> get(ProfileEntity forProfile);
    Stream<List<TransactionEntity>> observeProfile(ProfileEntity forProfile);
    Future<TransactionEntity> add(TransactionEntity transaction);
    Future<bool> remove(TransactionEntity transaction);
}