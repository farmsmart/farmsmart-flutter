import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'ArticleListItemStyle.dart';
import 'discover_page.dart';

class _DefaultStyle implements ArticleListItemStyle {
  static const Color titleColor = Color(0xFF1a1b46);
  static const Color bodyColor = Color(0xFF767690);

  final TextStyle titleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: titleColor);
  final TextStyle summaryTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: bodyColor);

  final EdgeInsets listEdgePadding = const EdgeInsets.only(left: 32.0, right: 32.0, top: 23, bottom: 23);
  final EdgeInsets cardMargin = const EdgeInsets.all(0);

  final double imageLineSpace = 22;
  final double imageHeight = 80;
  final double textLineSpace = 9.5;
  final double cardElevation = 0;

  final BorderRadius imageBorderRadius = const BorderRadius.all(Radius.circular(10.0));

  final int maxLinesPerTitle = 2;
  final int maxLinesPerSummary = 2;

  const _DefaultStyle();
}

class StandardListItem {
  Widget builder(ArticleListItemViewModel viewModel, {ArticleListItemStyle itemStyle = const _DefaultStyle()}) {
    return GestureDetector(
      onTap: viewModel.onTap,
      child: Card(
        margin: itemStyle.cardMargin,
        elevation: itemStyle.cardElevation,
        child: Column(
          children: <Widget>[
            Container(
              padding: itemStyle.listEdgePadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildArticleInformation(viewModel, itemStyle),
                  SizedBox(width: itemStyle.imageLineSpace),
                  _buildListItemImage(viewModel, itemStyle),
                ],
              ),
            ),
            ListDivider.build(),
          ],
        ),
      ),
    );
  }

  _buildListItemImage(ArticleListItemViewModel viewModel, ArticleListItemStyle itemStyle) {
    return ClipRRect(
        borderRadius: itemStyle.imageBorderRadius,
        child: NetworkImageFromFuture(
            viewModel.imageUrl,
            height: itemStyle.imageHeight,
            width: itemStyle.imageHeight,
            fit: BoxFit.cover)
    );
  }

  _buildArticleInformation(ArticleListItemViewModel viewModel, ArticleListItemStyle itemStyle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(viewModel.title ?? Strings.noTitleString,
              maxLines: itemStyle.maxLinesPerTitle,
              overflow: TextOverflow.ellipsis,
              style: itemStyle.titleTextStyle),
          SizedBox(height: itemStyle.textLineSpace),
          Text(viewModel.summary ?? Strings.myPlotItemDefaultTitle,
              maxLines: itemStyle.maxLinesPerSummary,
              overflow: TextOverflow.ellipsis,
              style: itemStyle.summaryTextStyle),
        ],
      ),
    );
  }
}
