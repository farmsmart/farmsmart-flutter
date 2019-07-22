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

  static final EdgeInsets circlePadding = EdgeInsets.only(
    right: 18,
    bottom: 5,
  );
  static final double circleSize = 20;
  static final double wrapSpacing = 8;
  static final double wrapRunSpacing = 8;

  static final EdgeInsets leadingPadding = EdgeInsets.only(top: 1);
}

class RecommendationDetailListItemViewModel {
  String iconPath;
  String title;
  String subtitle;
  List<Color> colors;

  RecommendationDetailListItemViewModel({
    this.iconPath,
    this.title,
    this.subtitle,
    this.colors = const <Color>[],
  });
}

class RecommendationDetailListItemStyle {
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final double iconSize;

  const RecommendationDetailListItemStyle({
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.iconSize,
  });

  RecommendationDetailListItemStyle copyWith({
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    double iconSize,
  }) {
    return RecommendationDetailListItemStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      iconSize: iconSize ?? this.iconSize,
    );
  }
}

class _DefaultStyle extends RecommendationDetailListItemStyle {
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

  const _DefaultStyle({
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    double iconSize,
  });
}

const RecommendationDetailListItemStyle _defaultStyle = const _DefaultStyle();

class RecommendationDetailListItem extends StatelessWidget {
  final RecommendationDetailListItemStyle _style;
  final RecommendationDetailListItemViewModel _viewModel;

  RecommendationDetailListItem({
    Key key,
    RecommendationDetailListItemViewModel viewModel,
    RecommendationDetailListItemStyle style = _defaultStyle,
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

  List<Widget> _buildCircles(List<Color> colors) => colors.map(
        (color) => Container(
          height: _Constants.circleSize,
          width:  _Constants.circleSize,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
      ).toList();

}
