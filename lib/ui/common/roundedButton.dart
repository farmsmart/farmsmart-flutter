import 'package:flutter/material.dart';

class RoundedButtonViewModel {
  String title;
  String icon;
  Function onTap;

  RoundedButtonViewModel({this.title, this.icon, this.onTap});
}

class RoundedButtonStyle {
  final Color iconButtonColor;
  final Color backgroundColor;
  final BoxShape buttonShape;
  final BorderRadius borderRadius;
  final TextStyle buttonTextStyle;
  final double height;
  final double width;
  final double iconEdgePadding;
  final double buttonIconSize;

  const RoundedButtonStyle({
    this.height,
    this.width,
    this.iconButtonColor,
    this.backgroundColor,
    this.iconEdgePadding,
    this.buttonShape,
    this.borderRadius,
    this.buttonTextStyle,
    this.buttonIconSize,
  });

  factory RoundedButtonStyle.defaultStyle() {
    return RoundedButtonStyle(
      iconButtonColor: Color(0xFFFFFFFF),
      backgroundColor: Color(0xff24d900),
      buttonShape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      buttonTextStyle: null,
      height: 24.0,
      width: 24.0,
      iconEdgePadding: 0,
      buttonIconSize: 9.0,
    );
  }

//TODO: Needs to style refactor, should be outside of the class.
  factory RoundedButtonStyle.bigRoundedButton() {
    return RoundedButtonStyle.defaultStyle().copyWith(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        height: 48.0,
        width: 48.0,
        buttonIconSize: 14.0);
  }

//TODO: Needs to style refactor, should be outside of the class.
  factory RoundedButtonStyle.largeRoundedButtonStyle() {
    return RoundedButtonStyle.defaultStyle().copyWith(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      buttonTextStyle: TextStyle(
          fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
      iconEdgePadding: 5,
      height: 56,
      width: double.infinity,
      buttonIconSize: null,
    );
  }

//TODO: Needs to style refactor, should be outside of the class.
  factory RoundedButtonStyle.actionSheetLargeRoundedButton() {
    return RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
      backgroundColor: Color(0xFFe9eaf2),
      buttonTextStyle: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF4c4e6e)),
    );
  }

  RoundedButtonStyle copyWith(
      {Color iconButtonColor,
      Color backgroundColor,
      BoxShape buttonShape,
      BorderRadius borderRadius,
      EdgeInsets edgePadding,
      TextStyle buttonTextStyle,
      double height,
      double width,
      double iconEdgePadding,
      double buttonIconSize}) {
    return RoundedButtonStyle(
      iconButtonColor: iconButtonColor ?? this.iconButtonColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      buttonShape: buttonShape ?? this.buttonShape,
      borderRadius: borderRadius ?? this.borderRadius,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      height: height ?? this.height,
      iconEdgePadding: iconEdgePadding ?? this.iconEdgePadding,
      width: width ?? this.width,
      buttonIconSize: buttonIconSize ?? this.buttonIconSize,
    );
  }
}

class RoundedButton extends StatelessWidget {
  final RoundedButtonViewModel _viewModel;
  final RoundedButtonStyle _style;

  const RoundedButton(
      {Key key, RoundedButtonViewModel viewModel, RoundedButtonStyle style})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:_viewModel.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: _style.height,
            width: _style.width,
            decoration: BoxDecoration(
                color: _style.backgroundColor != null
                    ? _style.backgroundColor
                    : _style.backgroundColor,
                shape: _style.buttonShape,
                borderRadius: _style.borderRadius),
            child: Wrap(
              direction: Axis.horizontal,
              children: _buildButtonContent(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildButtonContent() {
    List<Widget> listBuilder = [];
    if (_viewModel.icon != null) {
      listBuilder
          .add(Image.asset(_viewModel.icon, height: _style.buttonIconSize));
    }
    if (_viewModel.title != null) {
      listBuilder.add(Text(_viewModel.title, style: _style.buttonTextStyle));
    }
    return listBuilder;
  }
}
