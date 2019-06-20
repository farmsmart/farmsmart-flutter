import 'package:flutter/material.dart';

abstract class RoundedButtonStyle {

  final Color primaryIconButtonColor;
  final Color backgroundColor;
  final double height;

  final ShapeBorder buttonShape;

  final EdgeInsets edgePadding;
  final TextStyle buttonTextStyle;

  final double buttonIconSize;

  RoundedButtonStyle(this.height,
      this.primaryIconButtonColor, this.backgroundColor,
  {this.buttonShape, this.edgePadding,
      this.buttonTextStyle, this.buttonIconSize});
}

class defaultSmallRoundedButtonStyle implements RoundedButtonStyle {

  final Color primaryIconButtonColor =  const Color(0xFFFFFFFF);
  final Color backgroundColor =  const Color(0xff25df0c);

  final double height = 24.0;
  final double buttonIconSize = 15.0;

  final ShapeBorder buttonShape = const CircleBorder();

  final EdgeInsets edgePadding = const EdgeInsets.all(0);
  final TextStyle buttonTextStyle = null;

  const defaultSmallRoundedButtonStyle();
}

class defaultLargeRoundedButtonStyle implements RoundedButtonStyle {

  final Color primaryIconButtonColor =  const Color(0xFFFFFFFF);
  final Color backgroundColor =  const Color(0xff25df0c);

  final ShapeBorder buttonShape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)));

  final EdgeInsets edgePadding = const EdgeInsets.all(32);
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xffffffff));

  final double height = 60.0;
  final double buttonIconSize = null;

  const defaultLargeRoundedButtonStyle();
}

Widget buildRoundedButton(RoundedButtonStyle buttonStyle, {String title, IconData icon, Function onTap}) {

  List<Widget> _buildButtonContent(){
    List<Widget> listBuilder = [];
    if (icon != null) {
      listBuilder.add(
          Icon(
            icon,
            size: buttonStyle.buttonIconSize,
            color: buttonStyle.primaryIconButtonColor,
          )
      );
    }
      if (title != null) {
      listBuilder.add(
          Text(
            title,
            style: buttonStyle.buttonTextStyle
          ));
      }
      return listBuilder;
  }

  return Padding(
      padding: buttonStyle.edgePadding,
      child: SizedBox(
          height: buttonStyle.height,
          child: FlatButton(
              textColor: buttonStyle.primaryIconButtonColor,
              color: buttonStyle.backgroundColor,
              child: Wrap(
                direction: Axis.vertical,
                children: _buildButtonContent(),
              ),
              onPressed: () {},
              shape: buttonStyle.buttonShape
          )
      )
  );
}


