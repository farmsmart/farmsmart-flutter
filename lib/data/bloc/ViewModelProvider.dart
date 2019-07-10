import 'dart:async';

abstract class ViewModelProvider<T> {
  StreamController<T> provide();
}
