
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';

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

  static SizedBox generalListSmallerMargin() {
    return SizedBox(height: 7);
  }

  static boxPadding(){
    return EdgeInsets.all(16);
  }

  static articlePadding(){
    return EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 16);
  }

  static boxSmallPadding(){
    return EdgeInsets.all(12);
  }

  static leftPaddingSmall(){
    return EdgeInsets.only(left: 10);
  }

  static sidesPadding(){
    return EdgeInsets.only(left: 15, right: 15);
  }
}

abstract class Dividers {
  static ExpandableDivider(){
    return Divider(height: 4, color: Color(black));
  }
}
const double bottomBarIconSize = 30.0;
const double appBarIconSize = 30.0;
const double listImageHeight = 200.0;
const double listImageWidth = 400.0;
