import 'package:flutter/material.dart';
import 'listDivider.dart';

const Color titleColor = Color(0xFF1a1b46);
final TextStyle titleTextStyle = const TextStyle(
    fontSize: 17, fontWeight: FontWeight.normal, color: titleColor);

class ActionSheet {
  static build() {
    return Container(
      //color: Color(0xFF737373),
      color: Colors.orangeAccent,// This line set the transparent background
      child: Container(
        padding: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)
              )
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.5),
                  color: Color(0xFFe0e1ee),
                ),
              ),
              Card(
                elevation: 0,
                margin: EdgeInsets.only(top: 64.5, left: 32, right: 32),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.exit_to_app, size: 20),
                    SizedBox(width: 21.5),
                    Text("Record a new Sale", style: titleTextStyle)
                  ],
                ),
              ),
              SizedBox(height: 28.5),
              ListDivider.build(),
              SizedBox(height: 28.5),
              Card(
                margin: EdgeInsets.only(left: 32, right: 32),
                elevation: 0,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.launch, size: 20),
                    SizedBox(width: 21.5),
                    Text("Record a new cost", style: titleTextStyle)
                  ],
                ),
              ),
              SizedBox(height: 61.5),
              Container(
                margin: EdgeInsets.only(left: 32, right: 32),
                height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey,
                  )
              ),
              SizedBox(height: 32),
            ],
          )
      ),
    );
  }
}

