import 'dart:async';

import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/startup/viewmodel/startupViewModel.dart';

import '../ViewModelProvider.dart';

class StartupViewModelProvider implements ViewModelProvider<StartupViewModel> {
  StartupViewModel _snapshot;
  final StreamController<StartupViewModel> _controller = StreamController<StartupViewModel>.broadcast();
  
  @override
  StartupViewModel initial() {
    _snapshot = StartupViewModel(LoadingStatus.LOADING, _refresh, false);
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
    
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
