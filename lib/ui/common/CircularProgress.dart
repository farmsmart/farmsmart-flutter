import 'package:flutter/material.dart';
import 'dart:math';

class CircularProgress extends StatelessWidget {
  final Color _lineColor;
  final double _progress;
  final double _size;
  final double _lineWidth;
  final Color trackColor = Colors.transparent;
  final EdgeInsets innerPadding = const EdgeInsets.all(1.0);

  const CircularProgress(
      {Key key,
      @required double progress,
      @required double size,
      @required double lineWidth,
      Color lineColor})
      : this._lineColor = lineColor ?? const Color(0xff24d900),
        this._progress = progress,
        this._size = size,
        this._lineWidth = lineWidth,
        assert(progress >= 0 && progress <= 1,
            'Progress should be between 0 and 1'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: _size,
        width: _size,
        child: CustomPaint(
          foregroundPainter: _CircularPainter(
              trackColor: trackColor,
              lineColor: _lineColor,
              progress: _progress,
              width: _lineWidth),
          child: Padding(
            padding: innerPadding,
          ),
        ),
      ),
    );
  }
}

class _CircularPainter extends CustomPainter {
  Color trackColor;
  Color lineColor;
  double progress;
  double width;

  _CircularPainter(
      {this.trackColor, this.lineColor, this.progress, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = trackColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);

    double arcAngle = 2 * pi * progress;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
