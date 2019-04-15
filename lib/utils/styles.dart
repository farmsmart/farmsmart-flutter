
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:flutter/painting.dart';

abstract class Styles {

  static TextStyle titleTextStyle() {
    return TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(primaryGrey));
  }

  static TextStyle subtitleTextStyle() {
    return TextStyle(fontSize: 15, color: Color(primaryGrey));
  }

  static TextStyle appBarTextStyle() {
    return TextStyle(fontSize: 22,  fontWeight: FontWeight.bold,  color: Color(primaryGrey), letterSpacing: 1);
  }

  static TextStyle footerTextStyle() {
    return TextStyle(fontSize: 12, color: Color(black), decorationColor: Color(primaryGreen));
  }

}
