import 'package:farmsmart_flutter/model/entities/AccountEntity.dart';

abstract class AccountRepositoryInterface {
    Future<AccountEntity> getAuthorized();
    Future<AccountEntity> authorize(String username, String password);
    Future<AccountEntity> create(String username, String password);
}