import 'package:farmsmart_flutter/ui/common/Alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaygroundPresentButton extends StatelessWidget {
  final Widget child;
  final Function(Widget, BuildContext) present;

  const PlaygroundPresentButton({
    Key key,
    Function(Widget, BuildContext) listener,
    Widget child,
  })  : this.present = listener,
        this.child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text("Press Me"),
        onPressed: () => present(child, context),
      ),
    );
  }

  static presentModal(Widget modal, BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          body: SafeArea(child: modal),
        );
      }),
    );
  }
}
