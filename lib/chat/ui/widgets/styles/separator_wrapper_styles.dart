import 'package:farmsmart_flutter/chat/ui/widgets/separator_wrapper.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const defaultSeparatorColor = Color(0xFFF5F8FA);
  static const defaultSeparatorHeight = 2.0;
  static const defaultSeparatorMargin = 32.0;
  static const defaultChildMargin = 32.0;
}

class SeparatorWrapperStyles {
  static SeparatorWrapperStyle buildDefaultStyle() =>
      _defaultSeparatorWrapperStyle;

  static const _defaultSeparatorWrapperStyle = SeparatorWrapperStyle(
      childOuterMargins: const EdgeInsets.all(
        _Constants.defaultChildMargin,
      ),
      separatorMargins: const EdgeInsets.only(
        left: _Constants.defaultSeparatorMargin,
      ),
      separatorHeight: _Constants.defaultSeparatorHeight,
      separatorColor: _Constants.defaultSeparatorColor);
}
