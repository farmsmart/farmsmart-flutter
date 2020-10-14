import 'package:flutter/widgets.dart';

class ResetStateWidget extends StatefulWidget {
  final Widget child;

  ResetStateWidget({this.child});

  static resetState(BuildContext context) {
    final _ResetStateWidgetState state =
        context.findAncestorStateOfType();
    state.restartApp();
  }

  @override
  _ResetStateWidgetState createState() => _ResetStateWidgetState();
}

class _ResetStateWidgetState extends State<ResetStateWidget> {
  Key key = UniqueKey();

  void restartApp() {
    this.setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}