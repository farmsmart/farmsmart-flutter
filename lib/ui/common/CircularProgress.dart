import 'dart:async';

import 'package:farmsmart_flutter/ui/common/CircularPainter.dart';
import 'package:flutter/material.dart';

import 'network_image_from_future.dart';

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
          foregroundPainter: CircularPainter(
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
