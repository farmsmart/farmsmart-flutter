import 'package:flutter/material.dart';

abstract class RoundedButtonStyle {

  final Color primaryIconButtonColor;
  final Color primaryColor;
  final double roundedButtonSize;


  final BorderRadius roundedBorderRadius;

  final EdgeInsets actionButtonLargeEdgePadding;
  final TextStyle buttonTextStyle;

  final double buttonIconSize;

  RoundedButtonStyle(this.roundedButtonSize,
      this.primaryIconButtonColor, this.primaryColor,
  {this.roundedBorderRadius, this.actionButtonLargeEdgePadding,
      this.buttonTextStyle, this.buttonIconSize});
}

class _smallRoundedButtonStyle implements RoundedButtonStyle {

  final Color primaryIconButtonColor =  const Color(0xFFFFFFFF);
  final Color primaryColor =  const Color(0xff25df0c);

  final double roundedButtonSize = 24.0;
  final double buttonIconSize = 15.0;

  final BorderRadius roundedBorderRadius = null;
  final EdgeInsets actionButtonLargeEdgePadding = null;
  final TextStyle buttonTextStyle = null;

  const _smallRoundedButtonStyle();
}

class _largeRoundedButtonStyle implements RoundedButtonStyle {

  final Color primaryIconButtonColor =  const Color(0xFFFFFFFF);
  final Color primaryColor =  const Color(0xff25df0c);

  final BorderRadius roundedBorderRadius = const BorderRadius.all(Radius.circular(20.0));
  final EdgeInsets actionButtonLargeEdgePadding = const EdgeInsets.all(32);
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xffffffff));

  final double roundedButtonSize = 60.0;
  final double buttonIconSize = null;

  const _largeRoundedButtonStyle();
}

Widget buildAddCropTopButton({RoundedButtonStyle buttonStyle = const _smallRoundedButtonStyle()}){
  return SizedBox(
    height: buttonStyle.roundedButtonSize,
    child: FlatButton(
      child: Icon(
        Icons.add,
        size: buttonStyle.buttonIconSize,
        color: buttonStyle.primaryIconButtonColor,
      ),
        color: buttonStyle.primaryColor,
        onPressed: () {},
        shape: CircleBorder(
        )
    )
  );
}

Widget buildAddCropBottomButton(String title, {RoundedButtonStyle buttonStyle = const _largeRoundedButtonStyle(), Function onTap}){
  return Padding(
    padding: buttonStyle.actionButtonLargeEdgePadding,
    child: SizedBox(
      height: buttonStyle.roundedButtonSize,
      child: FlatButton(
          textColor: buttonStyle.primaryIconButtonColor,
          color: buttonStyle.primaryColor,
          child: Text(
              title,
              style: buttonStyle.buttonTextStyle),
          onPressed: () {},
          shape: RoundedRectangleBorder(
              borderRadius: buttonStyle.roundedBorderRadius)
      ),
    ),
  );
}

