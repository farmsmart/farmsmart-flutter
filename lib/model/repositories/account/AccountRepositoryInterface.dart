import 'package:farmsmart_flutter/model/model/AccountEntity.dart';

abstract class AccountRepositoryInterface {
    Future<AccountEntity> getLoggedIn();
}