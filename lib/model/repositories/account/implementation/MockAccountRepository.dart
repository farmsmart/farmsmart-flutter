import 'dart:math';

import 'package:farmsmart_flutter/model/model/AccountEntity.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';

import '../AccountRepositoryInterface.dart';

class _Strings {
  static const accountID = "Mock";
}

class _Constants {
  static const oneInChance = 1;
}

class MockAccountRepository implements AccountRepositoryInterface {

  final AccountEntity _account;
  final Random _rand = Random(0);
  
  MockAccountRepository._(this._account);

  factory MockAccountRepository(ProfileRepositoryInterface profileRepository) {
    return MockAccountRepository._(AccountEntity(_Strings.accountID, profileRepository));
  }
  
  @override
  Future<AccountEntity> authorize(String username, String password) {
    return Future.value(_account);
  }

  @override
  Future<AccountEntity> create(String token) {
    return Future.value(_account);
  }

  @override
  Future<AccountEntity> getAuthorized() {
    return (_rand.nextInt(_Constants.oneInChance) == 0) ? Future.value(null) : Future.value(_account);
  }

}