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

  RoundedButtonStyle copyWith({
    Color iconButtonColor,
    Color backgroundColor,
    BoxShape buttonShape,
    BorderRadius borderRadius,
    TextStyle buttonTextStyle,
    double height,
    double width,
    double iconEdgePadding,
    double buttonIconSize,
  }) {
    return RoundedButtonStyle(
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      buttonIconSize: buttonIconSize ?? this.buttonIconSize,
      buttonShape: buttonShape ?? this.buttonShape,
      iconButtonColor: iconButtonColor ?? this.iconButtonColor,
      iconEdgePadding: iconEdgePadding ?? this.iconEdgePadding,
      width: width ?? this.width,
    );
  }
}

class _DefaultRoundedButtonStyle extends RoundedButtonStyle {
  final Color iconButtonColor = const Color(0xFFFFFFFF);
  final Color backgroundColor = const Color(0xFF24D900);
  final BoxShape buttonShape = BoxShape.rectangle;
  final BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20));
  final TextStyle buttonTextStyle = null;
  final double height = 24.0;
  final double width = 24.0;
  final double iconEdgePadding = 0;
  final double buttonIconSize = 9.0;

  const _DefaultRoundedButtonStyle({
    Color iconButtonColor,
    Color backgroundColor,
    BoxShape buttonShape,
    BorderRadius borderRadius,
    TextStyle buttonTextStyle,
    double height,
    double width,
    double iconEdgePadding,
    double buttonIconSize,
  });
}

const RoundedButtonStyle _defaultStyle = const _DefaultRoundedButtonStyle();

class RoundedButton extends StatelessWidget {
  final RoundedButtonViewModel _viewModel;
  final RoundedButtonStyle _style;

  const RoundedButton({
    Key key,
    RoundedButtonViewModel viewModel,
    RoundedButtonStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _viewModel.onTap,
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
