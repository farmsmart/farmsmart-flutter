import 'package:farmsmart_flutter/model/bloc/chatFlow/NewProfileFlow.dart';
import 'package:farmsmart_flutter/model/repositories/account/AccountRepositoryInterface.dart';
import 'package:flutter/cupertino.dart';

class NewAccountFlow {
  final AccountRepositoryInterface _accountRepository;
  final NewProfileFlow _newProfile;

  NewAccountFlow(AccountRepositoryInterface accountRepository) : this._accountRepository = accountRepository, this._newProfile = NewProfileFlow(accountRepository);
  
  void run(BuildContext context, {Function onSuccess, Function onFail}){
    _createAccount(context, onSuccess, onFail);
  }

  void _createAccount(BuildContext context, Function onSuccess, Function onFail) {
      _accountRepository.anonymous().then((account) {
        if(account !=null){
          _newProfile.run(context, onSuccess: onSuccess, onFail: onFail);
        }
        else
        {
          onFail();
        }
      });
  }
}