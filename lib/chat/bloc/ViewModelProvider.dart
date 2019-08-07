import 'dart:async';

abstract class ViewModelProvider<T> {
  StreamController<T> observe();

  T initial();

  T snapshot();
}
