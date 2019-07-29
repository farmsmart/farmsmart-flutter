

import 'dart:async';

import 'package:farmsmart_flutter/data/bloc/ViewModelProvider.dart';

class StaticViewModelProvider<T> implements ViewModelProvider<T> {

  final T _viewModel;

  StaticViewModelProvider(T viewModel) : _viewModel = viewModel;

  @override
  T initial() {
    return _viewModel;
  }

  @override
  StreamController<T> observe() {
    return null;
  }

}