
import 'package:flutter/widgets.dart';

// We define here generic margins for the app

abstract class Margins {

  static SizedBox generalListMargin() {
    return SizedBox(height: 21);
  }

  static boxPadding(){
    return EdgeInsets.all(21);
  }

  static leftPaddingSmall(){
    return EdgeInsets.only(left: 10);
  }
}
