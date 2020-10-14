import 'dart:math' as math show sin, pi;

import 'package:farmsmart_flutter/chat/utils/delay_tween.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class TickerProviderMock extends Mock implements TickerProvider {}

void main() {
  group('Delay tween', () {
    final int durationInt = 100;
    final double durationDouble = 100.0;
    final double delay = 0;
    final double beginValue = 0;
    final double endValue = 1;
    final tickerProvider = TickerProviderMock();
    final DelayTween delayTween =
        DelayTween(begin: beginValue, end: endValue, delay: delay);
    final Animation<double> animation = AnimationController(
        vsync: tickerProvider, duration: Duration(milliseconds: durationInt));

    test('lerp() should return the expected value ', () {
      expect(delayTween.lerp(durationDouble),
          (math.sin((durationDouble - delay) * 2 * math.pi) + 1) / 2);
    });

    test('evaluate() should return the expected value', () {
      expect(delayTween.evaluate(animation), delayTween.lerp(animation.value));
    });
  });
}
