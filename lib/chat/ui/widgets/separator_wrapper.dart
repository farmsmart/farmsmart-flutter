import 'package:flutter/material.dart';

class _Constants {
  static const defaultSeparatorColor = Color(0xFFF5F8FA);
  static const defaultSeparatorHeight = 2.0;
  static const defaultSeparatorMargin = 32.0;
  static const defaultChildMargin = 32.0;
}

class SeparatorWrapperStyle {
  final Color separatorColor;
  final double separatorHeight;
  final EdgeInsetsGeometry separatorMargins;
  final EdgeInsetsGeometry childOuterMargins;

  const SeparatorWrapperStyle({
    this.separatorColor,
    this.separatorHeight,
    this.separatorMargins,
    this.childOuterMargins,
  });

  SeparatorWrapperStyle copyWith({
    Color separatorColor,
    double separatorHeight,
    EdgeInsetsGeometry separatorMargins,
    EdgeInsetsGeometry childOuterMargins,
  }) {
    return SeparatorWrapperStyle(
      separatorColor: separatorColor ?? this.separatorColor,
      separatorHeight: separatorHeight ?? this.separatorHeight,
      separatorMargins: separatorMargins ?? this.separatorMargins,
      childOuterMargins: childOuterMargins ?? this.childOuterMargins,
    );
  }
}

class _DefaultStyle extends SeparatorWrapperStyle {
  final Color separatorColor = _Constants.defaultSeparatorColor;
  final double separatorHeight = _Constants.defaultSeparatorHeight;
  final EdgeInsetsGeometry separatorMargins = const EdgeInsets.only(
    left: _Constants.defaultSeparatorMargin,
  );
  final EdgeInsetsGeometry childOuterMargins = const EdgeInsets.all(
    _Constants.defaultChildMargin,
  );

  const _DefaultStyle({
    Color separatorColor,
    double separatorHeight,
    EdgeInsetsGeometry separatorMargins,
    EdgeInsetsGeometry childOuterMargins,
  });
}

const SeparatorWrapperStyle _defaultStyle = const _DefaultStyle();

class SeparatorWrapper extends StatelessWidget {
  final SeparatorWrapperStyle _style;
  final Widget _wrappedChild;

  bool _notNull(Widget item) => item != null;

  SeparatorWrapper({
    SeparatorWrapperStyle style = _defaultStyle,
    Widget wrappedChild,
  })  : this._style = style,
        this._wrappedChild = wrappedChild;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSeparator(),
        _buildChild(),
      ].where(_notNull).toList(),
    );
  }

  _buildSeparator() {
    return Container(
      height: _style.separatorHeight,
      margin: _style.separatorMargins,
      color: _style.separatorColor,
    );
  }

  _buildChild() {
    return Container(
      margin: _style.childOuterMargins,
      child: _wrappedChild,
    );
  }
}
