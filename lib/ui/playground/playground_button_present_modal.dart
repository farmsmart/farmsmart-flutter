import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaygroundButtonPresentModal extends StatelessWidget {
  PlaygroundButtonPresentModal({Key key, this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text("Press Me"),
        onPressed: () => _onClick(context),
      ),
    );
  }

  _onClick(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) {
              return Scaffold(
                body: SafeArea(child: child),
              );
            }
        )
    );
  }
}

