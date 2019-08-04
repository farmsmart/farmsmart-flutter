//typedef Transformer<A,B> = B Function(A);

import 'dart:async';

abstract class ObjectTransformer<A,B> {
    B transform({A from});

    StreamTransformer<A,B> streamTransformer({Function(B) didTransform}) {
     return StreamTransformer<A,B>.fromHandlers(handleData: (input, sink) {
        final transformedObject = transform(from: input);
        if(didTransform !=null) {
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

