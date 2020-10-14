import 'dart:async';

abstract class ViewModelProvider<T> {

  Stream<T> stream();
  T initial();
  T snapshot();
  
}
