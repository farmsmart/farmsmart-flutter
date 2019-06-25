import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';

class LargeRoundedButtonStyle implements RoundedButtonStyle {

  final Color iconButtonColor =  const Color(0xFFFFFFFF);
  final Color backgroundColor =  const Color(0xff25df0c);
  final ShapeBorder buttonShape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)));

  final EdgeInsets edgePadding = const EdgeInsets.all(32);
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xffffffff));

  final double iconEdgePadding = 5;
  final double height = 60.0;
  final double buttonIconSize = null;

  const LargeRoundedButtonStyle();
}