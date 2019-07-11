import 'package:flutter/widgets.dart';

class PlaygroundWidget extends StatelessWidget {
  final String title;
  final Widget child;

  PlaygroundWidget({Key key, this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
