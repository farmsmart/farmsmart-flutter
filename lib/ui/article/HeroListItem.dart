import 'package:farmsmart_flutter/ui/article/viewModel/ArticleListItemViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/image_provider_view.dart';
import 'package:flutter/material.dart';

import 'ArticleListItemStyle.dart';

class _DefaultStyle implements ArticleListItemStyle {
  static const Color titleColor = Color(0xFF1a1b46);
  static const Color textColor = Color(0xFF767690);

  final TextStyle titleTextStyle = const TextStyle(
      fontSize: 17, fontWeight: FontWeight.w700, color: titleColor);
  final TextStyle summaryTextStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: textColor);

  final EdgeInsets listEdgePadding =
      const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 28);
  final EdgeInsets cardMargin = const EdgeInsets.all(0);

  final double imageHeight = 152;
  final double imageLineSpace = 22;
  final double textLineSpace = 9.5;
  final double cardElevation = 0;

  final BorderRadius imageBorderRadius =
      const BorderRadius.all(Radius.circular(14.0));

  final int maxLinesPerTitle = 1;
  final int maxLinesPerSummary = 3;

  const _DefaultStyle();
}

class HeroListItem extends StatelessWidget {
  final ArticleListItemViewModel _viewModel;
  final Function _onTap;

  const HeroListItem(
      {Key key, ArticleListItemViewModel viewModel, Function onTap})
      : this._viewModel = viewModel,
        this._onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _build(_viewModel);
  }

  Widget _build(ArticleListItemViewModel viewModel,
      {ArticleListItemStyle itemStyle = const _DefaultStyle()}) {
    return GestureDetector(
      onTap: _onTap,
      child: Column(
        children: <Widget>[
          Card(
            margin: itemStyle.cardMargin,
            elevation: itemStyle.cardElevation,
            child: Container(
              padding: itemStyle.listEdgePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeroArticleImage(viewModel, itemStyle),
                  SizedBox(height: itemStyle.imageLineSpace),
                  Text(viewModel.title,
                      maxLines: itemStyle.maxLinesPerTitle,
                      style: itemStyle.titleTextStyle),
                  SizedBox(height: itemStyle.textLineSpace),
                  Text(viewModel.summary,
                      maxLines: itemStyle.maxLinesPerSummary,
                      style: itemStyle.summaryTextStyle)
                ],
              ),
            ),
          ),
          ListDivider.build(),
        ],
      ),
    );
  }

  Widget _buildHeroArticleImage(ArticleListItemViewModel viewModel,
      ArticleListItemStyle articleListStyle) {
    return ImageProviderView(
      imageURLProvider: viewModel.image,
      imageBorderRadius: articleListStyle.imageBorderRadius,
      height: articleListStyle.imageHeight,
    );
  }
}
