import 'package:flutter/material.dart';

class ProfitLossHeaderViewModel {
  String title;
  String subtitle;
  String detail;

  ProfitLossHeaderViewModel(this.title, this.subtitle, this.detail);
}

class ProfitLossHeaderStyle {
  final TextStyle titleTextStyle;
  final TextStyle detailTextStyle;
  final TextStyle subtitleTextStyle;

  final EdgeInsets titleEdgePadding;
  final double detailTextSpacing;
  final int maxLines;

  ProfitLossHeaderStyle({this.titleTextStyle, this.detailTextStyle,
    this.subtitleTextStyle, this.titleEdgePadding, this.detailTextSpacing,
    this.maxLines});

  factory ProfitLossHeaderStyle.defaultStyle() {
    return ProfitLossHeaderStyle(
        titleTextStyle : const TextStyle(fontSize: 47, fontWeight: FontWeight.bold, color: Color(0xFF1a1b46)),
        detailTextStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xFF767690)),
        subtitleTextStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xFF25df0c)),
        titleEdgePadding: const EdgeInsets.only(left: 33, top: 36.5, bottom: 12.5, right: 33),
        detailTextSpacing: 10,
        maxLines: 1
    );
  }

  ProfitLossHeaderStyle copyWith({TextStyle titleTextStyle, TextStyle detailTextStyle,
    TextStyle subtitleTextStyle, EdgeInsets titleEdgePadding, double detailTextSpacing,
    int maxLines}) {
    return ProfitLossHeaderStyle(
        titleTextStyle : titleTextStyle ?? this.titleTextStyle,
        detailTextStyle: detailTextStyle ?? this.detailTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        titleEdgePadding: titleEdgePadding ?? this.titleEdgePadding,
        detailTextSpacing: detailTextSpacing ?? this.detailTextSpacing,
        maxLines: maxLines ?? this.maxLines
    );
  }
}

class ProfitLossHeader extends StatelessWidget {
  final ProfitLossHeaderViewModel _viewModel;
  final ProfitLossHeaderStyle _style;

  const ProfitLossHeader({Key key, ProfitLossHeaderViewModel viewModel, ProfitLossHeaderStyle style}) : this._viewModel = viewModel, this._style = style, super(key: key);

  static Widget _build(BuildContext context, ProfitLossHeaderViewModel viewModel, ProfitLossHeaderStyle style) {
    return Container(
      margin: style.titleEdgePadding,
      child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                    viewModel.title,
                    style: style.titleTextStyle,
                    maxLines: style.maxLines,
                    overflow: TextOverflow.ellipsis
                ),
                SizedBox(
                  width: style.detailTextSpacing,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          viewModel.detail,
                          style: style.detailTextStyle,
                          maxLines: style.maxLines,
                          overflow: TextOverflow.ellipsis
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                _buildSubTitle(viewModel, style),
              ],
            )
          ]),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return _build(context, _viewModel, _style);
  }
}