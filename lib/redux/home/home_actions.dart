import 'package:farmsmart_flutter/redux/home/screens.dart';

// We define here every single action that can happen in the home pack of tasks.
// This includes adding any kind of error and clearing them also.

class SwitchTabAction {
  final HomeScreen screen;
  SwitchTabAction(this.screen);
}
