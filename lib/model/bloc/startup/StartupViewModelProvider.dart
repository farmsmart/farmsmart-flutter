import 'dart:async';

import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/account/AccountRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/startup/viewmodel/startupViewModel.dart';

import '../ViewModelProvider.dart';

class StartupViewModelProvider implements ViewModelProvider<StartupViewModel> {
  final AccountRepositoryInterface _accountRepository;
  StartupViewModel _snapshot;
  final StreamController<StartupViewModel> _controller = StreamController<StartupViewModel>.broadcast();

  StartupViewModelProvider(this._accountRepository);
  
  @override
  StartupViewModel initial() {
    _snapshot = StartupViewModel(LoadingStatus.LOADING, _refresh, false,);
    _refresh();
    return _snapshot;
  }

  @override
  StartupViewModel snapshot() {
    return _snapshot;
  }

  @override
  Stream<StartupViewModel> stream() {
    return _controller.stream;
  }

  void _refresh() {
    _accountRepository.getAuthorized().then((account) {
      _snapshot = StartupViewModel(LoadingStatus.SUCCESS, _refresh, (account != null),);
      _controller.sink.add(_snapshot);
    });
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
