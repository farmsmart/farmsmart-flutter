import 'package:flutter/widgets.dart';

class PlaygroundWidget extends StatelessWidget {
  PlaygroundWidget({Key key, this.title, this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
