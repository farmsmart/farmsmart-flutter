import 'package:flutter/material.dart';

class _Constants {
  static const defaultOuterContainerMargin = const EdgeInsets.all(0.0);
  static const defaultRowMainAxisSize = MainAxisSize.max;
  static const defaultRowMainAxisAlignment = MainAxisAlignment.spaceBetween;
  static const defaultSizedBoxSeparatorWidth = 10.0;
  static const defaultLeftChildFlex = 4;
  static const defaultRightChildFlex = 1;
}

class PairContainerWrapperStyle {
  final EdgeInsetsGeometry outerContainerMargin;
  final MainAxisSize rowMainAxisSize;
  final MainAxisAlignment rowMainAxisAlignment;
  final double sizedBoxSeparatorWidth;
  final int leftChildFlex;
  final int rightChildFlex;

  const PairContainerWrapperStyle({
    this.outerContainerMargin,
    this.rowMainAxisSize,
    this.rowMainAxisAlignment,
    this.sizedBoxSeparatorWidth,
    this.leftChildFlex,
    this.rightChildFlex,
  });

  PairContainerWrapperStyle copyWith({
    EdgeInsetsGeometry outerContainerMargin,
    MainAxisSize rowMainAxisSize,
    MainAxisAlignment rowMainAxisAlignment,
    double sizedBoxSeparatorWidth,
    int childFlex,
    int buttonFlex,
  }) {
    return PairContainerWrapperStyle(
      outerContainerMargin: outerContainerMargin ?? this.outerContainerMargin,
      rowMainAxisSize: rowMainAxisSize ?? this.rowMainAxisSize,
      rowMainAxisAlignment: rowMainAxisAlignment ?? this.rowMainAxisAlignment,
      sizedBoxSeparatorWidth:
          sizedBoxSeparatorWidth ?? this.sizedBoxSeparatorWidth,
      leftChildFlex: childFlex ?? this.leftChildFlex,
      rightChildFlex: buttonFlex ?? this.rightChildFlex,
    );
  }
}

class _DefaultStyle extends PairContainerWrapperStyle {
  final EdgeInsetsGeometry outerContainerMargin =
      _Constants.defaultOuterContainerMargin;
  final MainAxisSize rowMainAxisSize = _Constants.defaultRowMainAxisSize;
  final MainAxisAlignment rowMainAxisAlignment =
      _Constants.defaultRowMainAxisAlignment;
  final double sizedBoxSeparatorWidth =
      _Constants.defaultSizedBoxSeparatorWidth;
  final int leftChildFlex = _Constants.defaultLeftChildFlex;
  final int rightChildFlex = _Constants.defaultRightChildFlex;

  const _DefaultStyle({
    EdgeInsetsGeometry outerContainerMargin,
    MainAxisSize rowMainAxisSize,
    MainAxisAlignment rowMainAxisAlignment,
    double sizedBoxSeparatorWidth,
    int childFlex,
    int buttonFlex,
  });
}

const PairContainerWrapperStyle _defaultStyle = const _DefaultStyle();

class PairContainerWrapper extends StatelessWidget {
  final PairContainerWrapperStyle _style;
  final Widget _leftChild;
  final Widget _rightChild;

  PairContainerWrapper({
    PairContainerWrapperStyle style = _defaultStyle,
    @required Widget leftChild,
    @required Widget rightChild,
  })  : this._style = style,
        this._leftChild = leftChild,
        this._rightChild = rightChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _style.outerContainerMargin,
      child: Row(
        mainAxisSize: _style.rowMainAxisSize,
        mainAxisAlignment: _style.rowMainAxisAlignment,
        children: <Widget>[
          _buildChildLeft(),
          _buildSpace(),
          _buildChildRight(),
        ],
      ),
    );
  }

  _buildChildLeft() => Flexible(
        flex: _style.leftChildFlex,
        child: _leftChild,
      );

  _buildSpace() => SizedBox(width: _style.sizedBoxSeparatorWidth);

  _buildChildRight() => Flexible(
        flex: _style.rightChildFlex,
        child: _rightChild,
      );
}
