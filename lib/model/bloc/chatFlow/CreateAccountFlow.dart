import 'package:farmsmart_flutter/model/bloc/chatFlow/NewProfileFlow.dart';
import 'package:farmsmart_flutter/model/repositories/account/AccountRepositoryInterface.dart';
import 'package:flutter/cupertino.dart';

import 'FlowCoordinator.dart';

class NewAccountFlowCoordinator implements FlowCoordinator {
  final AccountRepositoryInterface _accountRepository;
  final Function _onStatusChanged;
  bool _creatingAccount = false;
  NewProfileFlowCoordinator _newProfile;

  NewAccountFlowCoordinator(AccountRepositoryInterface accountRepository, Function onStatusChanged)
      : this._accountRepository = accountRepository, this._onStatusChanged = onStatusChanged;

  init() {
    _newProfile = NewProfileFlowCoordinator(_accountRepository, _profileFlowOnStatusChanged);
  }

  void run(BuildContext context, {Function onSuccess, Function onFail}) {
    _createAccount(context, onSuccess, onFail);
  }

  void _createAccount(
      BuildContext context, Function onSuccess, Function onFail) {
    _creatingAccount = true;
    _onStatusChanged(this);
    _accountRepository.anonymous().then((account) {
      if (account != null) {
        _newProfile.run(context, onSuccess: onSuccess, onFail: onFail);
      } else {
        onFail();
      }
      _creatingAccount = false;
    });
  }

  @override
  FlowCoordinatorStatus get status {
    if (_creatingAccount) {
      return FlowCoordinatorStatus.InProgress;
    }
    return _newProfile.status;
  }

  void _profileFlowOnStatusChanged(FlowCoordinator flow) {
    _onStatusChanged(this);
  }
}
