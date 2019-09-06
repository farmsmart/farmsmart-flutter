import 'package:flutter/material.dart';

class DogTagViewModel {
  String title;
  String number;
  IconData icon;

  DogTagViewModel({this.title, this.icon, this.number});
}

DogTagViewModel buildDogTagViewModel(
    {String title, IconData icon, String number}) {
  return DogTagViewModel(title: title, icon: icon, number: number);
}

class DogTagStyle {
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets edgePadding;
  final TextStyle titleTextStyle;
  final int maxLines;
  final double iconSize;
  final double spacing;
  final Color iconColor;

  const DogTagStyle(
      {this.backgroundColor,
      this.borderRadius,
      this.edgePadding,
      this.titleTextStyle,
      this.maxLines,
      this.iconSize,
      this.iconColor,
      this.spacing});

  DogTagStyle copyWith(
      {Color backgroundColor,
      BorderRadius borderRadius,
      EdgeInsets edgePadding,
      TextStyle titleTextStyle,
      int maxLines,
      double iconSize,
      Color iconColor,
      double spacing}) {
    return DogTagStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        borderRadius: borderRadius ?? this.borderRadius,
        edgePadding: edgePadding ?? this.edgePadding,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        maxLines: maxLines ?? this.maxLines,
        iconSize: iconSize ?? this.iconSize,
        iconColor: iconColor ?? this.iconColor,
        spacing: spacing ?? this.spacing);
  }
}

class _DefaultStyle extends DogTagStyle {
  final Color backgroundColor = const Color(0x1425df0c);
  final BorderRadius borderRadius =
      const BorderRadius.all(Radius.circular(20.0));
  final EdgeInsets edgePadding =
      const EdgeInsets.only(top: 4.5, right: 12, left: 12, bottom: 4.5);
  final TextStyle titleTextStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xff21c400));
  final int maxLines = 1;
  final double iconSize = 8;
  final Color iconColor = Colors.black;
  final double spacing = 5;

  const _DefaultStyle({
    Color backgroundColor,
    BorderRadius borderRadius,
    EdgeInsets edgePadding,
    TextStyle titleTextStyle,
    int maxLines,
    double iconSize,
    Color iconColor,
    double spacing,
  });
}

const DogTagStyle _defaultStyle = const _DefaultStyle();

class DogTag extends StatelessWidget {
  final DogTagViewModel _viewModel;
  final DogTagStyle _style;

  const DogTag(
      {Key key, DogTagViewModel viewModel, DogTagStyle style = _defaultStyle})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _style.edgePadding,
      decoration: BoxDecoration(
        color: _style.backgroundColor,
        borderRadius: _style.borderRadius,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: _buildButtonContent(
                  _viewModel,
                  _style,
                ),
                spacing: _style.spacing,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildButtonContent(
      DogTagViewModel viewModel, DogTagStyle style) {
    List<Widget> listBuilder = [];

    if (viewModel.icon != null) {
      listBuilder.add(
        Icon(
          viewModel.icon,
          size: style.iconSize,
          color: style.iconColor,
        ),
      );
    }
    if (viewModel.number != null) {
      listBuilder.add(
        Text(
          viewModel.number,
          style: style.titleTextStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: style.maxLines,
        ),
      );
    }
    if (viewModel.title != null) {
      listBuilder.add(
        Text(
          viewModel.title,
          style: style.titleTextStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: style.maxLines,
        ),
      );
    }
    return listBuilder;
  }
}
