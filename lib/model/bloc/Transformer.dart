//typedef Transformer<A,B> = B Function(A);

import 'dart:async';

abstract class ObjectTransformer<A, B> {
  B transform({A from});

  StreamTransformer<A, B> streamTransformer({Function(B) didTransform}) {
    return StreamTransformer<A, B>.fromHandlers(handleData: (input, sink) {
      final transformedObject = transform(from: input);
      if (didTransform != null) {
        didTransform(transformedObject);
      }
      return sink.add(transformedObject);
    });
  }
}

//Helper functions for safe casting when transforming
T castOrPlaceholder<T>(dynamic from, T placeholder) {
  return (from is T) ? from : placeholder;
}

T castOrNull<T>(dynamic from) {
  return castOrPlaceholder(from, null);
}

List<T> castListOrNull<T>(dynamic from) {
  return castListOrPlaceholder(from, null);
}

List<T> castListOrPlaceholder<T>(dynamic from, T placeholder) {
  final list = castOrNull<List<dynamic>>(from);
  if (list == null) {
    return [];
  }
  List<T> cast = [];
  list.forEach((item){
    final value = castOrPlaceholder<T>(item, placeholder);
    if(value != null){
      cast.add(value);
    }
  });
  return cast;
}

Map<Key, Value> castMapOrPlaceholder<Key, Value>(
    dynamic from, Value placeholder) {
  final inputMap = castOrNull<Map<dynamic, dynamic>>(from);
  if (inputMap == null) {
    return {};
  }
  Map<Key, Value> cast = {};
  inputMap.forEach((key, value) {
    final castKey = castOrNull<Key>(key);
    final castValue = castOrPlaceholder<Value>(value, placeholder);
    if (castKey != null && castValue != null) {
      cast[castKey] = castValue;
    }
  });
  return cast;
}

Map<Key, Value> castMapOrNull<Key, Value>(dynamic from) {
  return castMapOrPlaceholder(from, null);
}
