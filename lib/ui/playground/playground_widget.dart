import 'package:flutter/widgets.dart';

class PlaygroundWidget extends StatefulWidget {
  final String title;
  final Widget child;

  PlaygroundWidget({Key key, this.title, this.child});

  @override
  _PlaygroundWidgetState createState() => _PlaygroundWidgetState();
}

class _PlaygroundWidgetState extends State<PlaygroundWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

