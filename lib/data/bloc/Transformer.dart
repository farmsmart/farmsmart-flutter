//typedef Transformer<A,B> = B Function(A);
import 'package:flutter/foundation.dart';

abstract class ObjectTransformer<A,B> {
    B transform({A from});
}

//Helper functions for safe casting when transforming 
T castOrPlaceholder<T>(dynamic from, T placeholder) {
  return (from is T) ? from : placeholder;
}

T castOrNull<T>(dynamic from) {
  return castOrPlaceholder(from, null);
}

