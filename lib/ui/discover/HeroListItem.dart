import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:flutter/material.dart';

import 'StandardListItem.dart';
import 'discover_page.dart';

class HeroListItem {
  Widget builder(ArticlesItemListViewModel viewModel, {ArticleListItemStyle itemStyle = const HeroArticleListItemStyle()}) {
    return GestureDetector(
      onTap: viewModel.onTap,
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
          buildListDivider()
        ],
      ),
    );
  }
}

Widget _buildHeroArticleImage(ArticlesItemListViewModel articleData, ArticleListItemStyle articleListStyle) {
  return ClipRRect(
    borderRadius: articleListStyle.imageBorderRadius,
    child: NetworkImageFromFuture(articleData.imageUrl, fit: BoxFit.fitWidth),
  );
}