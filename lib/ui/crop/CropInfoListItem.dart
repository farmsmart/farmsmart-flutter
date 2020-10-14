import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _Constants {
  static final double leadingContainerHeight = 40;
  static final EdgeInsets titlePadding = const EdgeInsets.only(
    top: 12,
    bottom: 5.0,
  );
  static final EdgeInsets wrapColorsPadding = const EdgeInsets.only(
    top: 11.5,
  );
  static final double wrapSpacing = 8;
  static final double wrapRunSpacing = 8;

  static final EdgeInsets leadingPadding = EdgeInsets.only(top: 1);
  static final BorderRadius circleBorderRadius =
      BorderRadius.all(Radius.circular(30));
}

class CropInfoListItemViewModel {
  String iconPath;
  String title;
  String subtitle;
  List<Color> colors;

  CropInfoListItemViewModel({
    this.iconPath,
    this.title,
    this.subtitle,
    this.colors = const <Color>[],
  });
}

class CropInfoListItemStyle {
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final double iconSize;
  final double circleSize;

  const CropInfoListItemStyle({
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.iconSize,
    this.circleSize,
  });

  CropInfoListItemStyle copyWith({
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    double iconSize,
    double circleSize,
  }) {
    return CropInfoListItemStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      iconSize: iconSize ?? this.iconSize,
      circleSize: circleSize ?? this.circleSize,
    );
  }
}

class _DefaultStyle extends CropInfoListItemStyle {
  final TextStyle titleTextStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: Color(0xff4c4e6e),
  );

  final TextStyle subtitleTextStyle = const TextStyle(
    fontSize: 15,
    color: Color(0xff767690),
  );

  final double iconSize = 20;
  final double circleSize = 20;

  const _DefaultStyle({
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    double iconSize,
    double circleSize,
  });
}

const CropInfoListItemStyle _defaultStyle = const _DefaultStyle();

class CropInfoListItem extends StatelessWidget {
  final CropInfoListItemStyle _style;
  final CropInfoListItemViewModel _viewModel;

  CropInfoListItem({
    Key key,
    CropInfoListItemViewModel viewModel,
    CropInfoListItemStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildLeading(),
      title: _buildTitle(),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSubtitle(),
          _buildCirclesWrap(),
        ],
      ),
    );
  }

  _buildLeading() {
    return Container(
      padding: _Constants.leadingPadding,
      width: _Constants.leadingContainerHeight,
      alignment: Alignment.topRight,
      child: Image.asset(
        _viewModel.iconPath,
        width: _style.iconSize,
        height: _style.iconSize,
      ),
    );
  }

  _buildTitle() {
    return Padding(
      padding: _Constants.titlePadding,
      child: Text(
        _viewModel.title,
        style: _style.titleTextStyle,
      ),
    );
  }

  _buildSubtitle() {
    return Text(
      _viewModel.subtitle,
      style: _style.subtitleTextStyle,
    );
  }

  _buildCirclesWrap() {
    return Padding(
      padding: _Constants.wrapColorsPadding,
      child: Wrap(
        spacing: _Constants.wrapSpacing,
        runSpacing: _Constants.wrapRunSpacing,
        children: _buildCircles(_viewModel.colors),
      ),
    );
  }

  List<Widget> _buildCircles(List<Color> colors) => colors
      .map(
        (color) => Container(
              height: _style.circleSize,
              width: _style.circleSize,
              decoration: BoxDecoration(
                color: color,
                borderRadius: _Constants.circleBorderRadius,
              ),
            ),
      )
      .toList();
}
