//typedef Transformer<A,B> = B Function(A);

import 'dart:async';

abstract class ObjectTransformer<A,B> {
    B transform({A from}) { return null;}

    StreamTransformer<A,B> streamTransformer() {
     return StreamTransformer<A,B>.fromHandlers(handleData: (input, sink) {
        return sink.add(transform(from: input));
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

