import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardViewStyle {
  final EdgeInsetsGeometry mainContainerMargin;
  final double borderRadius;
  final Color shadowColor;
  final double shadowRadius;
  final double cardElevation;

  const CardViewStyle({
    this.borderRadius,
    this.shadowColor,
    this.shadowRadius,
    this.cardElevation,
    this.mainContainerMargin,
  });

  CardViewStyle copyWith({
    double borderRadius,
    Color shadowColor,
    double shadowRadius,
    double cardElevation,
    EdgeInsetsGeometry mainContainerMargin,
  }) {
    return CardViewStyle(
      mainContainerMargin: mainContainerMargin ?? this.mainContainerMargin,
      cardElevation: cardElevation ?? this.cardElevation,
      shadowRadius: shadowRadius ?? this.shadowRadius,
      shadowColor: shadowColor ?? this.shadowColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}

class _DefaultStyle extends CardViewStyle {
  final double borderRadius = 10.0;
  final Color shadowColor = const Color(0xFFBDBDBD);
  final double shadowRadius = 40.0;
  final double cardElevation = 0.0;
  final EdgeInsetsGeometry mainContainerMargin = const EdgeInsets.all(20.0);

  const _DefaultStyle({
    double borderRadius,
    Color shadowColor,
    double shadowRadius,
    double cardElevation,
    EdgeInsetsGeometry mainContainerMargin,
  });
}

const CardViewStyle _defaultStyle = const _DefaultStyle();

class CardView extends StatelessWidget {
  final CardViewStyle _style;
  final Widget _child;

  CardView({
    CardViewStyle style = _defaultStyle,
    Widget child,
  })  : this._child = child,
        this._style = style;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _style.mainContainerMargin,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child: Card(
              elevation: _style.cardElevation,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_style.borderRadius)),
              child: Center(
                child: _child,
              ),
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: _style.shadowColor,
                  blurRadius: _style.shadowRadius,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
