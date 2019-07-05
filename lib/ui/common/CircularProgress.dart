import 'dart:async';

import 'package:farmsmart_flutter/ui/common/MyPainter.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatefulWidget {
  @override
  _CircularProgressState createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress> {
  double percentage = 0;
  double increment = 10;
  double defaultValue = 0;
  double percentageComplete = 100.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 87,
        width: 87,
        child: CustomPaint(
          foregroundPainter: MyPainter(
              lineColor: Colors.transparent,
              completeColor: Color(0xff24d900),
              completePercent: percentage,
              width: 3.0),
          child: Padding(
            padding: EdgeInsets.all(4.0),
          ),
        ),
      ),
    );
  }

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
  }
}
