import 'package:farmsmart_flutter/chat/utils/delay_tween.dart';
import 'package:flutter/material.dart';

class FadingDots extends StatefulWidget {
  static const int _defaultMilliseconds = 1400;
  static const Duration _defaultDuration =
      Duration(milliseconds: _defaultMilliseconds);
  static const double _defaultSize = 20.0;

  FadingDots({
    Key key,
    this.color = Colors.grey,
    this.size = _defaultSize,
    this.duration = _defaultDuration,
  })  : assert(color != null, 'You should specify a color'),
        assert(size != null),
        assert(duration.inMilliseconds >= 0.0,
            'The duration should be greater than 0'),
        super(key: key);

  final Color color;
  final double size;
  final Duration duration;

  @override
  _FadingDotsState createState() => _FadingDotsState();
}

class _FadingDotsState extends State<FadingDots>
    with SingleTickerProviderStateMixin {
  static const double _halfSizeFactor = .5;
  static const double _delayFactorZero = .0;
  static const double _delayFactorTwo = .2;
  static const double _delayFactorFour = .4;
  static const double _beginAlpha = 0.0;
  static const double _endAlpha = 1.0;
  static const int _doubleSizeFactor = 2;
  static const int _firstIndex = 0;
  static const int _secondIndex = 1;
  static const int _thirdIndex = 2;

  AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController =
        AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox.fromSize(
        size: Size(widget.size * _doubleSizeFactor, widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _circle(_firstIndex, _delayFactorZero),
            _circle(_secondIndex, _delayFactorTwo),
            _circle(_thirdIndex, _delayFactorFour),
          ],
        ),
      ),
    );
  }

  Widget _circle(int index, double delay) {
    final _size = widget.size * _halfSizeFactor;
    return FadeTransition(
      opacity: DelayTween(
        begin: _beginAlpha,
        end: _endAlpha,
        delay: delay,
      ).animate(_fadeController),
      child: SizedBox.fromSize(
        size: Size.square(_size),
        child: _itemBuilder(index),
      ),
    );
  }

  Widget _itemBuilder(int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.color,
        shape: BoxShape.circle,
      ),
    );
  }
}
