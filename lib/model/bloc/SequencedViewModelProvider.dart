

import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';

class SequencedViewModelProvider<T> implements ViewModelProvider<T> {

  final Duration _tempo;
  final List<T> _sequence;
  final StreamController _controller = StreamController<T>.broadcast();
  int _index = 1;
  Timer _timer;

  SequencedViewModelProvider(List<T> sequence,{ Duration tempo = const Duration(seconds: 1)}) : _sequence = sequence, _tempo = tempo;

  @override
  T initial() {
    if(_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(_tempo, (timer) {
       _updateToNextViewModel();
    });
    return _sequence.first;
  }

  @override
  Stream<T> stream() {
    return _controller.stream;
  }

  @override
  T snapshot() {
    return _sequence[_index % _sequence.length];
  }

  void stop() {
     _timer.cancel();
  }

  _updateToNextViewModel() {
      _controller.sink.add(snapshot());
      _index++;
  }

  void dispose(){
    _timer.cancel();
    _controller.sink.close();
    _controller.close();
  }

}