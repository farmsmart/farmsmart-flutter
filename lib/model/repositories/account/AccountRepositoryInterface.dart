import 'package:farmsmart_flutter/model/entities/AccountEntity.dart';

abstract class AccountRepositoryInterface {
    Stream<AccountEntity> observeAuthorized();
    Future<AccountEntity> authorized();
    Future<AccountEntity> authorize(String username, String password);
    Future<AccountEntity> create(String username, String password);
    Future<AccountEntity> anonymous();
    Future<bool> deauthorize();
}