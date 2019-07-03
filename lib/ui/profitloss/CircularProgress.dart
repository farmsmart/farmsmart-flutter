
import 'package:farmsmart_flutter/ui/profitloss/MyPainter.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatefulWidget {
  @override
  _CircularProgressState createState() => _CircularProgressState();
}


class _CircularProgressState extends State<CircularProgress>{

  double percentage;
  @override
  void initState(){

    super.initState();
    setState(() {
      percentage = 0.0;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: CustomPaint(
          foregroundPainter: MyPainter(
              lineColor: Colors.amber,
              completeColor: Colors.blueAccent,
              completePercent: percentage,
            width: 8.0
          ),
          child: Padding(
              padding: EdgeInsets.all(8.0),
          child: RaisedButton(
              color: Colors.purple,
              splashColor: Colors.blueAccent,
              shape: CircleBorder(),
              child: Text("Click"),
              onPressed: () {
                setState(() {
                  percentage += 10.0;
                  if (percentage>100.0){
                    percentage = 0.0;
                  }
                });
              }),
          ),
        ),
      ),
    );
  }



}