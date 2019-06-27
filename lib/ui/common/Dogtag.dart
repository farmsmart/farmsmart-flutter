import 'package:flutter/material.dart';

class DogTagViewModel {

  String title;

  //TODO: can be a decimal number or only Integers numbers?
  int number;
  IconData icon;
  DogTagViewModel({this.title, this.icon, this.number});
}

DogTagViewModel buildDogTagViewModel({String title, IconData icon, int number}) {
  return DogTagViewModel(title: title, icon: icon, number: number);
}

abstract class DogTagStyle {
  final Color backgroundColor;

  final BorderRadius borderRadius;

  final EdgeInsets edgePadding;
  final TextStyle titleTextStyle;

  final int maxLines;
  final double iconSize;
  final double spacing;

  DogTagStyle(this.backgroundColor, this.borderRadius,
      this.edgePadding, this.titleTextStyle, this.maxLines, this.iconSize, this.spacing);

}
class _DefaultStyle implements DogTagStyle {

  final BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20.0));
  final Color backgroundColor = const Color(0x1425df0c);
  final EdgeInsets edgePadding = const EdgeInsets.only(top: 8.5, right: 12, left: 12, bottom: 8);
  final TextStyle titleTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff25df0c));

  final int maxLines = 1;
  final double iconSize = 8;
  final double spacing = 5.5;

  const _DefaultStyle();
}

class DogTag {
  static build(
  {DogTagStyle style = const _DefaultStyle(),
  String title, IconData icon, int number}) {
    return _buildDogTag(style, title: title, icon: icon, number: number);
  }

  static Widget _buildDogTag(DogTagStyle style, {String title, icon, int number}) {
    String plusSign = "+";
    String minusSign = "-";

    DogTagViewModel viewModel = buildDogTagViewModel(title: title, icon: icon, number: number);

    List<Widget> _buildButtonContent(){
      List<Widget> listBuilder = [];

      if (viewModel.icon!= null) {
        listBuilder.add(
          Icon(
            viewModel.icon,
            size: style.iconSize,
            color: Colors.black,
          ),
        );
      } if (viewModel.number != null) {
          listBuilder.add(
              Text(
                viewModel.number >= 0 ? plusSign + viewModel.number.toString():
                minusSign + viewModel.number.toString(),
                style: style.titleTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: style.maxLines,
              )
          );
      } if (viewModel.title != null) {
        listBuilder.add(
          Text(
            viewModel.title,
            style: style.titleTextStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: style.maxLines,
          )
        );
      }
      return listBuilder;
    }

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
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: _buildButtonContent(),
                  spacing: style.spacing,
                ))
          ],
        ),
      );
    }
  }
