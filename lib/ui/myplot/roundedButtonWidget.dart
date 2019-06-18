import 'package:flutter/material.dart';

abstract class RoundedButtonStyle {

  final Color primaryIconButtonColor;
  final Color primaryColor;

  final BorderRadius roundedBorderRadius;

  final EdgeInsets actionButtonLargeEdgePadding;
  final TextStyle buttonTextStyle;

  final double roundedButtonSize;
  final double buttonIconSize;

  RoundedButtonStyle(this.roundedButtonSize, this.buttonIconSize,
      this.primaryIconButtonColor, this.primaryColor,
      this.roundedBorderRadius, this.actionButtonLargeEdgePadding,
      this.buttonTextStyle);
}


class _smallRoundedButtonStyle implements RoundedButtonStyle {

  final Color primaryIconButtonColor =  const Color(0xFFFFFFFF);
  final Color primaryColor =  const Color(0xff25df0c);

  final double roundedButtonSize = 25.0;
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
  final EdgeInsets actionButtonLargeEdgePadding = const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0, top: 31.0);
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xffffffff));

  final double roundedButtonSize = 56.0;
  final double buttonIconSize = null;

  const _largeRoundedButtonStyle();
}

Widget buildAddCropTopButton({RoundedButtonStyle buttonStyle = const _smallRoundedButtonStyle()}){
  return ButtonTheme(
    height: buttonStyle.roundedButtonSize,
    child: FlatButton(
      onPressed: () {},
      child: Icon(
        Icons.add,
        size: buttonStyle.buttonIconSize,
        color: buttonStyle.primaryIconButtonColor,
      ),
      shape: CircleBorder(),
      color: buttonStyle.primaryColor,
    ),
  );
}

Widget buildAddCropBottomButton(String title, {RoundedButtonStyle buttonStyle = const _largeRoundedButtonStyle()} ){
  return Container(
    height: buttonStyle.roundedButtonSize,
    margin: buttonStyle.actionButtonLargeEdgePadding,
    width: double.infinity,
    decoration: BoxDecoration(
      color: buttonStyle.primaryColor,
      borderRadius: buttonStyle.roundedBorderRadius,
    ),
    child: FlatButton(
        child: Text(
            title,
            style: buttonStyle.buttonTextStyle
        ),
        onPressed: () {
          //FIXME: Add oPressed when CropAddList available
        }
    ),
  );
}

