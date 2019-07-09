import 'dart:async';

import 'package:farmsmart_flutter/ui/common/MyPainter.dart';
import 'package:flutter/material.dart';

import 'network_image_from_future.dart';

class CircularProgressViewModel {
  double initialValue;
  double increment;
  List<Widget> content;

  CircularProgressViewModel({@required this.initialValue, this.increment, this.content});
}

abstract class CircularProgressStyle {
  final double height;
  final double width;
  final Color completeColor;
  final Color lineColor;
  final double testWidth;
  final EdgeInsets edgePadding;

  CircularProgressStyle(this.height, this.width, this.completeColor,
      this.lineColor, this.testWidth, this.edgePadding);

  CircularProgressStyle copyWith(
      {double height,
      double width,
      Color completeColor,
      Color lineColor,
      double testWidth,
      EdgeInsets edgePadding});
}

class _DefaultStyle implements CircularProgressStyle {
  final double height = 87;
  final double width = 87;
  final Color completeColor = const Color(0xff24d900);
  final Color lineColor = Colors.transparent;
  final double testWidth = 3;
  final EdgeInsets edgePadding = const EdgeInsets.all(4.0);

  const _DefaultStyle(
      {double height,
      double width,
      Color completeColor,
      Color lineColor,
      double testWidth,
      EdgeInsets edgePadding});

  @override
  CircularProgressStyle copyWith(
      {double height,
      double width,
      Color completeColor,
      Color lineColor,
      double testWidth,
      EdgeInsets edgePadding}) {
    return _DefaultStyle(
        height: height ?? this.height,
        width: width ?? this.width,
        completeColor: completeColor ?? this.completeColor,
        lineColor: lineColor ?? this.lineColor,
        testWidth: testWidth ?? this.testWidth,
        edgePadding: edgePadding ?? this.edgePadding);
  }
}

const CircularProgressStyle _defaultStyle = const _DefaultStyle();

class CircularProgress extends StatefulWidget {
  final CircularProgressStyle _style;
  final CircularProgressViewModel _viewModel;

  CircularProgress(
      {Key key,
      @required CircularProgressViewModel viewModel,
      CircularProgressStyle style = _defaultStyle})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  _CircularProgressState createState() =>
      _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress> {

  double defaultValue = 0;
  double percentageComplete = 100.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      //startTimer();
      //checkPercentage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: widget._style.height,
        width: widget._style.width,
        child: CustomPaint(
          foregroundPainter: MyPainter(
              lineColor: widget._style.lineColor,
              completeColor: widget._style.completeColor,
              completePercent: widget._viewModel.initialValue,
              width: widget._style.testWidth),
          child: Padding(
            padding: widget._style.edgePadding,
            child: ClipOval(
              child: Stack(
                  children: widget._viewModel.content),
            ),
          ),
        ),
      ),
    );
  }

  void checkPercentage() {
    widget._viewModel.initialValue += widget._viewModel.increment;
    if (widget._viewModel.increment > percentageComplete) {
      widget._viewModel.initialValue = defaultValue;
    }
  }
/*
  void startTimer() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if(this.mounted){
        setState(() {
          percentage += increment;
          if (percentage > percentageComplete) {
            percentage = defaultValue;
          }
        });
      }
    });
  }*/
}
