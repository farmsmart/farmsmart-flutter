import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';

class LargeRoundedButtonStyle implements RoundedButtonStyle {

  final Color iconButtonColor =  const Color(0xFFFFFFFF);
  final Color backgroundColor =  const Color(0xff25df0c);

  final BoxShape buttonShape = BoxShape.rectangle;
  final BorderRadius borderShape = const BorderRadius.all(Radius.circular(16));

  final EdgeInsets edgePadding = const EdgeInsets.only(left: 32, top: 31, right: 32, bottom: 32);
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xffffffff));

  final double iconEdgePadding = 5;
  final double size = 56.0;
  final double buttonIconSize = null;

  const LargeRoundedButtonStyle();
}