import 'package:flutter/material.dart';
import 'dart:math';

class CircularProgress extends StatefulWidget {
  final Color _lineColor;
  final double _progress;

  const CircularProgress({Key key, @required double progress, Color lineColor})
      : this._lineColor = lineColor ?? const Color(0xff24d900),
        this._progress = progress,
        super(key: key);

  @override
  _CircularProgressState createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress> {
  double defaultValue = 0;
  double percentageComplete = 100.0;
  final double height = 87;
  final double width = 87;
  final Color lineColor = Colors.transparent;
  final double lineWidth = 3;
  final EdgeInsets innerPadding = const EdgeInsets.all(4.0);

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        child: CustomPaint(
          foregroundPainter: _CircularPainter(
              lineColor: lineColor,
              completeColor: widget._lineColor,
              completePercent: widget._progress,
              width: lineWidth),
          child: Padding(
            padding: innerPadding,
          ),
        ),
      ),
    );
  }
}

class _CircularPainter extends CustomPainter{
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;


  _CircularPainter({this.lineColor, this.completeColor, this.completePercent,
    this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width/2, size.height/2);
    double radius = min(size.width/2, size.height/2);
    canvas.drawCircle(
        center,
        radius,
        line
    );

    double arcAngle = 2*pi* (completePercent/100);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi/2,
        arcAngle,
        false,
        complete
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
