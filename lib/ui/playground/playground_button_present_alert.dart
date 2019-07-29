import 'package:farmsmart_flutter/ui/common/Alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaygroundButtonPresentAlert extends StatelessWidget {
  final Alert alert;
  final Function(Alert, BuildContext) listener;


  const PlaygroundButtonPresentAlert({
    Key key,
    Alert alert,
    Function(Alert, BuildContext) listener,
    Widget child,
  })  : this.listener = listener,
  this.alert = alert,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text("Press to Show Alert"),
        onPressed: () => listener(
          alert,
          context),
      ),
    );
  }
}
