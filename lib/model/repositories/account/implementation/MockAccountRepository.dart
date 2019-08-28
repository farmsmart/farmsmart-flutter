import 'dart:async';
import 'package:farmsmart_flutter/model/entities/AccountEntity.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';

import '../AccountRepositoryInterface.dart';

class _Strings {
  static const accountID = "Mock";
}

class MockAccountRepository implements AccountRepositoryInterface {

  final AccountEntity _account;
  final _streamController = StreamController<AccountEntity>.broadcast();
  bool _created=false;
  
  MockAccountRepository._(this._account);

  factory MockAccountRepository(ProfileRepositoryInterface profileRepository) {
    return MockAccountRepository._(AccountEntity(_Strings.accountID, profileRepository));
  }
  
  @override
  Future<AccountEntity> authorize(String username, String password) {
    final futureAccount = Future.value(_account);
    _streamController.sink.add(_account);
    return futureAccount;
  }

  @override
  Future<AccountEntity> create(String username, String password) {
    final futureAccount = Future.value(_account);
    _created = true;
     _streamController.sink.add(_account);
    return futureAccount;
  }

  @override
  Future<AccountEntity> authorized() {
    return _created ? Future.value(_account) :  Future.value(null);
  }

  @override
  Future<AccountEntity> anonymous() {
     final futureAccount = Future.value(_account);
    _streamController.sink.add(_account);
    return futureAccount;
  }

  @override
  Future<bool> deauthorize() {
    _created = false;
    _streamController.sink.add(null);
    return Future.value(true);
  }

  @override
  Stream<AccountEntity> observeAuthorized() {
    return _streamController.stream;
  }

  void deinit(){
    _streamController.sink.close();
    _streamController.close();
  }

}