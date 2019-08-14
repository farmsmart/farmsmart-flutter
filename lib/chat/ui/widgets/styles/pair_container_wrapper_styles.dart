import 'package:farmsmart_flutter/chat/ui/widgets/pair_container_wrapper.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const defaultOuterContainerMargin = const EdgeInsets.all(0.0);
  static const defaultRowMainAxisSize = MainAxisSize.max;
  static const defaultRowMainAxisAlignment = MainAxisAlignment.spaceBetween;
  static const defaultLeftChildFlex = 4;
  static const defaultRightChildFlex = 1;
  static const defaultSizedBoxSeparatorWidth = 20.0;
}

class PairContainerWrapperStyles {
  static PairContainerWrapperStyle buildDefaultStyle() =>
      _defaultPairContainerWrapperStyle;

  static const _defaultPairContainerWrapperStyle = PairContainerWrapperStyle(
    outerContainerMargin: _Constants.defaultOuterContainerMargin,
    rowMainAxisAlignment: _Constants.defaultRowMainAxisAlignment,
    rowMainAxisSize: _Constants.defaultRowMainAxisSize,
    leftChildFlex: _Constants.defaultLeftChildFlex,
    rightChildFlex: _Constants.defaultRightChildFlex,
    sizedBoxSeparatorWidth: _Constants.defaultSizedBoxSeparatorWidth,
  );
}
