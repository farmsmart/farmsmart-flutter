import 'dart:async';

abstract class ViewModelProviderInterface<T> {

  Stream<T> stream();
  T initial();
  T snapshot();
  
}
