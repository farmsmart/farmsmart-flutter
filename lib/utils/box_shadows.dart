import 'package:flutter/material.dart';

import 'colors.dart';

abstract class BoxShadows {
  static List<BoxShadow> plotListItemShadow() {
    return [
      BoxShadow(
          color: Color(primaryGreyLight),
          offset: Offset(0.0, 10.0),
          blurRadius: 10.0)
    ];
  }
}
