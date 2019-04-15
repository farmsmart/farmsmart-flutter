
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:flutter/painting.dart';

abstract class Styles {

  static TextStyle titleTextStyle() {
    return TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(primaryDarkGrey));
  }

  static TextStyle subtitleTextStyle() {
    return TextStyle(fontSize: 15, color: Color(primaryDarkGrey));
  }

  static TextStyle footerTextStyle() {
    return TextStyle(fontSize: 12, color: Color(black), decorationColor: Color(primaryGreen));
  }

}
