import 'package:flutter/material.dart';

class RoundedButtonViewModel {
  String title;
  String icon;
  Function onTap;
  Color backgroundColor; // shouldn't be here

  RoundedButtonViewModel({this.title, this.icon, this.onTap, this.backgroundColor});
}

class RoundedButtonStyle {
  final Color iconButtonColor;
  final Color backgroundColor;
  final BoxShape buttonShape;
  final BorderRadius borderRadius;
  final EdgeInsets edgePadding;
  final TextStyle buttonTextStyle;
  final double size;
  final double iconEdgePadding;
  final double buttonIconSize;

  RoundedButtonStyle({this.size,
    this.iconButtonColor, this.backgroundColor, this.iconEdgePadding,
    this.buttonShape, this.borderRadius, this.edgePadding,
    this.buttonTextStyle, this.buttonIconSize});

  factory RoundedButtonStyle.defaultStyle() {
    return RoundedButtonStyle(
        iconButtonColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xff24d900),
        buttonShape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        edgePadding: EdgeInsets.all(0),
        buttonTextStyle: null,
        size: 24.0,
        iconEdgePadding: 0,
        buttonIconSize: 9.0
    );
  }

  factory RoundedButtonStyle.compactRoundedButton() {
    return RoundedButtonStyle.defaultStyle().copyWith();
  }

  factory RoundedButtonStyle.compactBigRoundedButton() {
    return RoundedButtonStyle.defaultStyle().copyWith(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        size: 48.0,
        buttonIconSize: 14.0
    );
  }

  factory RoundedButtonStyle.largeRoundedButtonStyle() {
    return RoundedButtonStyle.defaultStyle().copyWith(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      edgePadding: EdgeInsets.only(left: 32, top: 31, right: 32, bottom: 32),
      buttonTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
      iconEdgePadding: 5,
      size: 56,
      buttonIconSize: null,

    );
  }

  factory RoundedButtonStyle.actionSheetLargeRoundedButton(){
    return RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
        backgroundColor: Color(0xFFe9eaf2),
        buttonTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF4c4e6e)),
    );
  }

  RoundedButtonStyle copyWith({Color iconButtonColor, Color backgroundColor,
    BoxShape buttonShape, BorderRadius borderRadius, EdgeInsets edgePadding,
    TextStyle buttonTextStyle, double size, double iconEdgePadding,
    double buttonIconSize}) {

    return RoundedButtonStyle (
        iconButtonColor: iconButtonColor ?? this.iconButtonColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        buttonShape: buttonShape ?? this.buttonShape,
        borderRadius: borderRadius ?? this.borderRadius,
        edgePadding: edgePadding ?? this.edgePadding,
        buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
        size: size ?? this.size, iconEdgePadding: iconEdgePadding ?? this.iconEdgePadding,
        buttonIconSize: buttonIconSize ?? this.buttonIconSize
    );
  }
}


class RoundedButton  extends StatelessWidget {
  final RoundedButtonViewModel _viewModel;
  final RoundedButtonStyle _style;

  const RoundedButton({Key key, RoundedButtonViewModel viewModel, RoundedButtonStyle style }) : this._viewModel = viewModel, this._style = style, super(key: key);

  static Widget _build(RoundedButtonViewModel viewModel, RoundedButtonStyle style) {

    List<Widget> _buildButtonContent(){
      List<Widget> listBuilder = [];
      if (viewModel.icon != null) {
        listBuilder.add(
            Image.asset(viewModel.icon, height: style.buttonIconSize)
        );
      }
      if (viewModel.title != null) {
        listBuilder.add(
            Text(
                viewModel.title,
                style: style.buttonTextStyle
            ));
      }
      return listBuilder;
    }

    return GestureDetector(
      onTap: () => viewModel.onTap(),
      child: Padding(
        padding: style.edgePadding,
        child: Container(
          alignment: Alignment.center,
          height: style.size,
          width: style.size,
          decoration: BoxDecoration(
              color: viewModel.backgroundColor != null ? viewModel.backgroundColor : style.backgroundColor,
              shape: style.buttonShape,
              borderRadius: style.borderRadius
          ),
          child: Wrap(
            direction: Axis.horizontal,
            children: _buildButtonContent(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(_viewModel, _style);
  }


}
