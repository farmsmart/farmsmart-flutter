import 'package:flutter/material.dart';

class DogTagViewModel {

  String title;
  String number;
  IconData icon;

  DogTagViewModel({this.title, this.icon, this.number});
}

DogTagViewModel buildDogTagViewModel({String title, IconData icon, String number}) {
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

  DogTagStyle({this.backgroundColor, this.borderRadius,
      this.edgePadding, this.titleTextStyle, this.maxLines,
      this.iconSize, this.spacing});

  factory DogTagStyle.defaultStyle() {
    return DogTagStyle(
      backgroundColor: Color(0x1425df0c),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      edgePadding: EdgeInsets.only(top: 8.5, right: 12, left: 12, bottom: 8),
      titleTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff25df0c)),
      maxLines: 1,
      iconSize: 8,
      spacing: 5.5
    );
  }

  factory DogTagStyle.positiveStyle() {
    return DogTagStyle.defaultStyle().copyWith();
  }

  factory DogTagStyle.negativeStyle() {
    return DogTagStyle.positiveStyle().copyWith(
      backgroundColor: Color(0x14ff8d4f),
      titleTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xffff8d4f))
    );
  }

  factory DogTagStyle.compactStyle() {
    return DogTagStyle.defaultStyle().copyWith(
      edgePadding: EdgeInsets.only(left: 12, top: 5.5, right: 12, bottom: 5.5),
      titleTextStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xff25df0c))
    );
  }


  DogTagStyle copyWith({Color backgroundColor, BorderRadius borderRadius,
    EdgeInsets edgePadding, TextStyle titleTextStyle, int maxLines, double iconSize,
    double spacing}) {

    return DogTagStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      edgePadding: edgePadding ?? this.edgePadding,
      titleTextStyle: titleTextStyle ?? this. titleTextStyle,
      maxLines: maxLines ?? this.maxLines,
      iconSize: iconSize ?? this.iconSize,
      spacing: spacing ?? this.spacing
    );
  }
}

class DogTag extends StatelessWidget {
  final DogTagViewModel _viewModel;
  final DogTagStyle _style;

  const DogTag({Key key, DogTagViewModel viewModel, DogTagStyle style }) : this._viewModel = viewModel, this._style = style, super(key:key);

  static Widget _build(DogTagViewModel viewModel, DogTagStyle style) {

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
                viewModel.number,
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

  @override
  Widget build(BuildContext context) {
    return _build(_viewModel, _style);
  }
  }
