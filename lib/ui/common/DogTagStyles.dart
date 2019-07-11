import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:farmsmart_flutter/ui/common/Dogtag.dart';

class DogTagStyles {
  static DogTagStyle positiveStyle() {
    return _defaultStyle;
  }

  static DogTagStyle negativeStyle() {
    return _defaultStyle.copyWith(
      backgroundColor: Color(0x14ff8d4f),
      titleTextStyle: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xffff8d4f)),
    );
  }

  static DogTagStyle compactStyle() {
    return _defaultStyle.copyWith(
        edgePadding:
            EdgeInsets.only(left: 12, top: 5.5, right: 12, bottom: 5.5),
        titleTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xff21c400)));
  }

  static DogTagStyle _defaultStyle = DogTagStyle(
      backgroundColor: Color(0x1425df0c),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      edgePadding: EdgeInsets.only(top: 4.5, right: 12, left: 12, bottom: 4.5),
      titleTextStyle: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xff21c400)),
      maxLines: 1,
      iconSize: 8,
      iconColor: Colors.black,
      spacing: 5.5);
}
