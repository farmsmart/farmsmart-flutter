import 'dart:math';

import 'package:farmsmart_flutter/model/model/AccountEntity.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';

import '../AccountRepositoryInterface.dart';

class _Strings {
  static const accountID = "Mock";
}

class MockAccountRepository implements AccountRepositoryInterface {

  final AccountEntity _account;
  bool _created=false;
  
  MockAccountRepository._(this._account);

  factory MockAccountRepository(ProfileRepositoryInterface profileRepository) {
    return MockAccountRepository._(AccountEntity(_Strings.accountID, profileRepository));
  }
  
  @override
  Future<AccountEntity> authorize(String username, String password) {
    return Future.value(_account);
  }

  @override
  Future<AccountEntity> create(String username, String password) {
    _created = true;
    return Future.value(_account);
  }

  @override
  Future<AccountEntity> getAuthorized() {
    return _created ? Future.value(_account) :  Future.value(null);
  }

}