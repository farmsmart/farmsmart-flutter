import 'package:flutter/material.dart';

class RoundedBackgroundTextViewModel {
  String title;
  IconData icon;

  RoundedBackgroundTextViewModel({this.title, this.icon});
}

RoundedBackgroundTextViewModel buildBackgroundTextViewModel({String title, IconData icon}) {
  return RoundedBackgroundTextViewModel(title: title, icon: icon);
}

abstract class RoundedBackgroundTextStyle {
  final Color backgroundColor;

  final BorderRadius borderRadius;

  final EdgeInsets edgePadding;
  final TextStyle titleTextStyle;

  final int maxLines;

  RoundedBackgroundTextStyle(this.backgroundColor, this.borderRadius,
      this.edgePadding, this.titleTextStyle, this.maxLines); //X

}
class _DefaultStyle implements RoundedBackgroundTextStyle {

  final BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20.0));
  final Color backgroundColor = const Color(0x1425df0c);
  final EdgeInsets edgePadding = const EdgeInsets.only(top: 8.5, right: 12, left: 12, bottom: 8);
  final TextStyle titleTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff25df0c));

  final int maxLines = 1;
  const _DefaultStyle();
}


class RoundedBackgroundText {
  static build(
  {RoundedBackgroundTextStyle style = const _DefaultStyle(),
  String title, IconData icon}) {
    return _buildRoundedBackgroundText(style, title: title, icon: icon);
  }

  static Widget _buildRoundedBackgroundText(RoundedBackgroundTextStyle style, {String title, icon}) {
    String defaultValue = "0";

    RoundedBackgroundTextViewModel viewModel = buildBackgroundTextViewModel(title: title, icon: icon);

      return Container(
        padding: style.edgePadding,
        decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: style.borderRadius
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children:
          <Widget>[
            Flexible(
                child: Container(
                  child: Text(
                    viewModel.title ?? defaultValue,
                    style: style.titleTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: style.maxLines,
                  ),
                ))
          ],
        ),
      );
    }
  }
