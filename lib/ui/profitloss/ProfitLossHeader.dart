import 'package:flutter/material.dart';

class ProfitLossHeaderViewModel {
  String title;
  String detail;

  ProfitLossHeaderViewModel(this.title, this.detail);
}

class ProfitLossHeaderStyle {
  final TextStyle titleTextStyle;
  final TextStyle detailTextStyle;
  final TextStyle subtitleTextStyle;

  final EdgeInsets titleEdgePadding;
  final double detailTextSpacing;
  final int maxLines;

  ProfitLossHeaderStyle(
      {this.titleTextStyle,
      this.detailTextStyle,
      this.subtitleTextStyle,
      this.titleEdgePadding,
      this.detailTextSpacing,
      this.maxLines});

  factory ProfitLossHeaderStyle.defaultStyle() {
    return ProfitLossHeaderStyle(
        titleTextStyle: const TextStyle(
            fontSize: 47,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1a1b46)),
        detailTextStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Color(0xFF767690)),
        subtitleTextStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: Color(0xFF25df0c)),
        titleEdgePadding:
            const EdgeInsets.only(left: 33, top: 36.5, bottom: 12.5, right: 33),
        detailTextSpacing: 10,
        maxLines: 1);
  }

  ProfitLossHeaderStyle copyWith(
      {TextStyle titleTextStyle,
      TextStyle detailTextStyle,
      TextStyle subtitleTextStyle,
      EdgeInsets titleEdgePadding,
      double detailTextSpacing,
      int maxLines}) {
    return ProfitLossHeaderStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        detailTextStyle: detailTextStyle ?? this.detailTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        titleEdgePadding: titleEdgePadding ?? this.titleEdgePadding,
        detailTextSpacing: detailTextSpacing ?? this.detailTextSpacing,
        maxLines: maxLines ?? this.maxLines);
  }
}

class ProfitLossHeader extends StatelessWidget {
  final ProfitLossHeaderViewModel _viewModel;
  final ProfitLossHeaderStyle _style;

  const ProfitLossHeader(
      {Key key,
      ProfitLossHeaderViewModel viewModel,
      ProfitLossHeaderStyle style})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _style.titleEdgePadding,
      child: Column(children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Text(_viewModel.title,
                style: _style.titleTextStyle,
                maxLines: _style.maxLines,
                overflow: TextOverflow.ellipsis),
            SizedBox(
              width: _style.detailTextSpacing,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_viewModel.detail,
                      style: _style.detailTextStyle,
                      maxLines: _style.maxLines,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }

  //FIXME: Out of scope for the moment
  /*
  static Widget _buildSubTitle(ProfitLossHeaderViewModel viewModel, ProfitLossHeaderStyle style) {
    return Container(
        child: GestureDetector(
          child: Text(
              viewModel.subtitle,
              style: style.subtitleTextStyle
          ),
          onTap: () {
            //FIXME: Add navigation to the next screen when finished
          },
        ));
  }
*/
}
