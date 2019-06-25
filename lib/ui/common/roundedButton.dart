import 'package:flutter/material.dart';

class RoundedButtonViewModel {
  String title;
  IconData icon;
  Function onTap;
  BuildContext context;

  RoundedButtonViewModel(this.context, {this.title, this.icon, this.onTap});
}

RoundedButtonViewModel buildButtonViewModel(BuildContext context, {String title, IconData icon, Function onTap}) {
  return RoundedButtonViewModel(context, title: title, icon : icon, onTap: () => onTap(context));
}

abstract class RoundedButtonStyle {

  final Color iconButtonColor;
  final Color backgroundColor;

  final ShapeBorder buttonShape;

  final EdgeInsets edgePadding;
  final TextStyle buttonTextStyle;

  final double height;
  final double iconEdgePadding;
  final double buttonIconSize;

  RoundedButtonStyle(this.height,
      this.iconButtonColor, this.backgroundColor, this.iconEdgePadding,
  {this.buttonShape, this.edgePadding,
      this.buttonTextStyle, this.buttonIconSize});
}

class _DefaultStyle implements RoundedButtonStyle {

  final Color iconButtonColor =  const Color(0xFFFFFFFF);
  final Color backgroundColor =  const Color(0xff25df0c);
  final ShapeBorder buttonShape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)));

  final EdgeInsets edgePadding = const EdgeInsets.all(32);
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xffffffff));

  final double iconEdgePadding = 5;
  final double height = 60.0;
  final double buttonIconSize = null;

  const _DefaultStyle();
}

class RoundedButton {
  static build(
      {RoundedButtonStyle style = const _DefaultStyle(),
        @required  BuildContext context,
        String title, IconData icon,
        Function onTap}) {
    return _buildRoundedButton(style, context , title: title, icon: icon, onTap: onTap);
  }

  static Widget _buildRoundedButton(RoundedButtonStyle buttonStyle, BuildContext context, {String title, IconData icon,
    Function onTap}) {

    RoundedButtonViewModel viewModel = buildButtonViewModel(context, title: title, icon: icon, onTap: onTap);

    List<Widget> _buildButtonContent(){
      List<Widget> listBuilder = [];
      if (viewModel.icon != null) {
        listBuilder.add(
            Icon(
              viewModel.icon,
              size: buttonStyle.buttonIconSize,
              color: buttonStyle.iconButtonColor,
            )
        );
      }
      if (viewModel.title != null) {
        listBuilder.add(
            Text(
                viewModel.title,
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
                onPressed: () => _showToast(viewModel.context),
                shape: buttonStyle.buttonShape
            )
        )
    );
  }

//FIXME: Only is built for show that this buttons are not functional yet
  static void _showToast(BuildContext context) {
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
}



