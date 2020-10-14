import 'package:farmsmart_flutter/chat/ui/widgets/fading_dots.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const _defaultMilliseconds = 1400;
  static const _defaultDuration = Duration(
    milliseconds: _defaultMilliseconds,
  );
  static const _defaultSize = 6.0;
  static const _defaultSpaceBetweenDots = 5.0;
  static const _defaultDotColor = Color(0xFF767690);
}

class FadingDotsStyles {
  static FadingDotsStyle buildDefaultStyle() => _defaultStyle;

  static const _defaultStyle = FadingDotsStyle(
    spaceBetweenDots: _Constants._defaultSpaceBetweenDots,
    size: _Constants._defaultSize,
    duration: _Constants._defaultDuration,
    color: _Constants._defaultDotColor,
  );
}
