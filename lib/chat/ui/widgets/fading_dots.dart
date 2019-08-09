import 'package:farmsmart_flutter/chat/utils/delay_tween.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const _defaultMilliseconds = 1400;
  static const _defaultDuration = Duration(
    milliseconds: _defaultMilliseconds,
  );
  static const _defaultSize = 6.0;
  static const _defaultSpaceBetweenDots = 5.0;
  static const _defaultDotColor = Color(0xFF767690);

  static const double _delayFactorZero = .0;
  static const double _delayFactorTwo = .2;
  static const double _delayFactorFour = .4;
  static const double _beginAlpha = 0.0;
  static const double _endAlpha = 1.0;
  static const int _firstIndex = 0;
  static const int _secondIndex = 1;
  static const int _thirdIndex = 2;
}

class FadingDotsStyle {
  final Color color;
  final double size;
  final double spaceBetweenDots;
  final Duration duration;

  const FadingDotsStyle({
    this.spaceBetweenDots,
    this.size,
    this.color,
    this.duration,
  });

  FadingDotsStyle copyWith({
    Color color,
    double size,
    double spaceBetweenDots,
    Duration duration,
  }) {
    return FadingDotsStyle(
      color: color ?? this.color,
      duration: duration ?? this.duration,
      size: size ?? this.size,
      spaceBetweenDots: spaceBetweenDots ?? this.spaceBetweenDots,
    );
  }
}

class _DefaultFadingDotsStyle extends FadingDotsStyle {
  final Color color = _Constants._defaultDotColor;
  final double size = _Constants._defaultSize;
  final double spaceBetweenDots = _Constants._defaultSpaceBetweenDots;
  final Duration duration = _Constants._defaultDuration;

  const _DefaultFadingDotsStyle({
    Color color,
    double size,
    double spaceBetweenDots,
    Duration duration,
  });
}

const FadingDotsStyle _defaultStyle = const _DefaultFadingDotsStyle();

class FadingDots extends StatefulWidget {
  FadingDots({
    Key key,
    FadingDotsStyle style = _defaultStyle,
  })  : this._style = style,
        super(key: key);

  final FadingDotsStyle _style;

  @override
  _FadingDotsState createState() => _FadingDotsState();
}

class _FadingDotsState extends State<FadingDots>
    with SingleTickerProviderStateMixin {
  AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController =
        AnimationController(vsync: this, duration: widget._style.duration)
          ..repeat();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _circle(
          _Constants._firstIndex,
          _Constants._delayFactorZero,
        ),
        _sizedBox(),
        _circle(
          _Constants._secondIndex,
          _Constants._delayFactorTwo,
        ),
        _sizedBox(),
        _circle(
          _Constants._thirdIndex,
          _Constants._delayFactorFour,
        ),
      ],
    );
  }

  Widget _sizedBox() {
    return SizedBox(width: widget._style.spaceBetweenDots);
  }

  Widget _circle(int index, double delay) {
    return FadeTransition(
      opacity: DelayTween(
        begin: _Constants._beginAlpha,
        end: _Constants._endAlpha,
        delay: delay,
      ).animate(_fadeController),
      child: SizedBox.fromSize(
        size: Size.square(widget._style.size),
        child: _itemBuilder(index),
      ),
    );
  }

  Widget _itemBuilder(int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget._style.color,
        shape: BoxShape.circle,
      ),
    );
  }
}
