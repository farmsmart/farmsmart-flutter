import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';

class CompactRoundedButtonStyle implements RoundedButtonStyle {

  final Color iconButtonColor =  const Color(0xFFFFFFFF);
  final Color backgroundColor =  const Color(0xff24d900);

  final double size = 24.0;
  final double buttonIconSize = 15.0;

  final BoxShape buttonShape = BoxShape.rectangle;
  final BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20));

  final double iconEdgePadding = 0;
  final EdgeInsets edgePadding = const EdgeInsets.all(0);
  final TextStyle buttonTextStyle = null;

  const CompactRoundedButtonStyle();
}