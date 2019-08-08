import 'package:farmsmart_flutter/ui/common/modal_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaygroundPresentButton extends StatelessWidget {
  final Widget child;

  const PlaygroundPresentButton({
    Key key,
    Function(Widget, BuildContext) listener,
    Widget child,
  })  : this.child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text("Press Me"),
        onPressed: () => NavigationScope.presentModal(context, child),
      ),
    );
  }
}
