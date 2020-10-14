//typedef Transformer<A,B> = B Function(A);
import 'package:flutter/foundation.dart';

abstract class ObjectTransformer<A, B> {
  B transform({
    @required A from,
  });
}
