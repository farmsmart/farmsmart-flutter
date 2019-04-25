
import 'package:flutter/widgets.dart';

// We define here generic margins for the app

abstract class Margins {

  static SizedBox generalListBigMargin() {
    return SizedBox(height: 20);
  }

  static SizedBox generalListMargin() {
    return SizedBox(height: 16);
  }

  static SizedBox generalListSmallMargin() {
    return SizedBox(height: 12);
  }

  static SizedBox generalHorizontalPadding() {
    return SizedBox(width: 16);
  }

  static boxBigPadding(){
    return EdgeInsets.all(20);
  }


  static boxPadding(){
    return EdgeInsets.all(16);
  }

  static boxSmallPadding(){
    return EdgeInsets.all(12);
  }

  static leftPaddingSmall(){
    return EdgeInsets.only(left: 10);
  }
}

const double bottomBarIconSize = 30.0;
const double appBarIconSize = 30.0;
