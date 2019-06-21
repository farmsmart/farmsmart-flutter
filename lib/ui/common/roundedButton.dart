import 'package:flutter/material.dart';

class RoundedButtonViewModel {
  String title;
  IconData icon;
  Function onTap;
  BuildContext context;

  RoundedButtonViewModel(this.title, this.icon, this.onTap, this.context);
}

abstract class _RoundedButtonStyle {

  final Color iconButtonColor;
  final Color backgroundColor;

  final ShapeBorder buttonShape;

  final EdgeInsets edgePadding;
  final TextStyle buttonTextStyle;

  final double height;
  final double iconEdgePadding;
  final double buttonIconSize;

  _RoundedButtonStyle(this.height,
      this.iconButtonColor, this.backgroundColor, this.iconEdgePadding,
  {this.buttonShape, this.edgePadding,
      this.buttonTextStyle, this.buttonIconSize});
}

class _LargeRoundedButtonStyle implements _RoundedButtonStyle {

  final Color iconButtonColor =  const Color(0xFFFFFFFF);
  final Color backgroundColor =  const Color(0xff25df0c);
  final ShapeBorder buttonShape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)));

  final EdgeInsets edgePadding = const EdgeInsets.all(32);
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xffffffff));

  final double iconEdgePadding = 5;
  final double height = 60.0;
  final double buttonIconSize = null;

  const _LargeRoundedButtonStyle();
}

class _SmallRoundedButtonStyle implements _RoundedButtonStyle {

  final Color iconButtonColor =  const Color(0xFFFFFFFF);
  final Color backgroundColor =  const Color(0xff25df0c);

  final double height = 24.0;
  final double buttonIconSize = 15.0;

  final ShapeBorder buttonShape = const CircleBorder();

  final double iconEdgePadding = 0;
  final EdgeInsets edgePadding = const EdgeInsets.all(0);
  final TextStyle buttonTextStyle = null;

  const _SmallRoundedButtonStyle();
}

class RoundedButton {
  static buildSmall(
  {_RoundedButtonStyle style = const _SmallRoundedButtonStyle(),
    @required  BuildContext context,
    String title, IconData icon,
    Function onTap}) {
    return buildRoundedButton(style, context , title: title, icon: icon, onTap: onTap);
  }
  static buildLarge(
      {_RoundedButtonStyle style = const _LargeRoundedButtonStyle(),
        @required  BuildContext context,
        String title, IconData icon,
        Function onTap}) {
    return buildRoundedButton(style, context , title: title, icon: icon, onTap: onTap);
  }
}

//FIXME: Make a class for button and should be in the common file, create viewModel.
Widget buildRoundedButton(_RoundedButtonStyle buttonStyle, BuildContext context, {String title, IconData icon,
  Function onTap}) {

  List<Widget> _buildButtonContent(){
    List<Widget> listBuilder = [];
    if (icon != null) {
      listBuilder.add(
          Icon(
            icon,
            size: buttonStyle.buttonIconSize,
            color: buttonStyle.iconButtonColor,
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
              textColor: buttonStyle.iconButtonColor,
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

