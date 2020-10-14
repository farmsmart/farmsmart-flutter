import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';

class StaticViewModelProvider<T> implements ViewModelProvider<T> {

  final T _viewModel;
  final StreamController _controller = StreamController<T>.broadcast();

  StaticViewModelProvider(T viewModel) : _viewModel = viewModel;

  @override
  T initial() {
    return _viewModel;
  }

  @override
  Stream<T> stream() {
    return _controller.stream;
  }

  @override
  T snapshot() {
    return _viewModel;
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }

}