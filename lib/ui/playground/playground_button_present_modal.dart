import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaygroundButtonPresentModal extends StatelessWidget {
  PlaygroundButtonPresentModal({Key key, this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text("Press Me"),
        onPressed: () => _onTap(context),
      ),
    );
  }

  _onTap(BuildContext context) {
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

