import 'package:flutter/material.dart';

abstract class RoundedButtonStyle {

  final Color IconButtonColor;
  final Color backgroundColor;

  final ShapeBorder buttonShape;

  final EdgeInsets edgePadding;
  final TextStyle buttonTextStyle;

  final double height;
  final double iconEdgePadding;
  final double buttonIconSize;

  RoundedButtonStyle(this.height,
      this.IconButtonColor, this.backgroundColor, this.iconEdgePadding,
  {this.buttonShape, this.edgePadding,
      this.buttonTextStyle, this.buttonIconSize});
}

Widget buildRoundedButton(RoundedButtonStyle buttonStyle, {String title, IconData icon, Function onTap, BuildContext context}) {

  List<Widget> _buildButtonContent(){
    List<Widget> listBuilder = [];
    if (icon != null) {
      listBuilder.add(
          Icon(
            icon,
            size: buttonStyle.buttonIconSize,
            color: buttonStyle.IconButtonColor,
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
              textColor: buttonStyle.IconButtonColor,
              color: buttonStyle.backgroundColor,
              child: Wrap(
                spacing: buttonStyle.iconEdgePadding,
                direction: Axis.horizontal,
                children: _buildButtonContent(),
              ),
              onPressed: () => _showToast(context),
              shape: buttonStyle.buttonShape
          )
      )
  );
}

//FIXME: Only is built for show that this buttons are not functional yet
void _showToast(BuildContext context) {
  final String toastText = "Not Implemented Yet";
  final String toastButtonText = "BACK";
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
      SnackBar(
        content: Text(
            toastText
            ),
        action: SnackBarAction(label: toastButtonText, onPressed: scaffold.hideCurrentSnackBar),
      )
  );
}

