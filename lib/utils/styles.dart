
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:flutter/painting.dart';

abstract class Styles {

  static TextStyle titleTextStyle() {
    return TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(titleBlack));
  }

  static TextStyle subtitleTextStyle() {
    return TextStyle(fontSize: 15, color: Color(subtitleGrey));
  }

  static TextStyle footerTextStyle() {
    return TextStyle(fontSize: 13, color: Color(footerGrey));
  }

}
