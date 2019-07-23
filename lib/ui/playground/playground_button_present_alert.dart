import 'package:farmsmart_flutter/ui/common/AlertWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaygroundButtonPresentAlert extends StatelessWidget {
  PlaygroundButtonPresentAlert({Key key, this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text("Press to Show Alert"),
        onPressed: () => _onTap(context),
      ),
    );
  }
  _onTap(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) => child
    );
  }
}
