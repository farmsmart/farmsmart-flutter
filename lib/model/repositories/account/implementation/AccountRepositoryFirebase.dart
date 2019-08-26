import 'package:farmsmart_flutter/model/model/AccountEntity.dart';
import 'package:farmsmart_flutter/model/repositories/account/AccountRepositoryInterface.dart';

class AccountRepositoryFirebase implements AccountRepositoryInterface {
  @override
  Future<AccountEntity> getAuthorized() {
    return null;
  }

  @override
  Future<AccountEntity> authorize(String username, String password) {
    // TODO: implement authorize
    return null;
  }

  @override
  Future<AccountEntity> create(String username, String password) {
    // TODO: implement create
    return null;
  }
}