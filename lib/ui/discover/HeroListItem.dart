import 'package:farmsmart_flutter/ui/common/widgets/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:flutter/material.dart';
import 'ArticleListItemStyle.dart';
import 'discover_page.dart';

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

class HeroListItem {
  Widget builder(BuildContext context, ArticleListItemViewModel viewModel, {ArticleListItemStyle itemStyle = const _DefaultStyle()}) {
    return GestureDetector(
      //onTap: viewModel.onTap,
      onTap: () => _onMenuPressed(context), //FIXME: Temporal for test ActionBottomSheet
      child: Column(
        children: <Widget>[
          Card(
            margin: itemStyle.cardMargin,
            elevation: itemStyle.cardElevation,
            child: Container(
              padding: itemStyle.listEdgePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[ _buildHeroArticleImage(viewModel, itemStyle),
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

  Widget _buildHeroArticleImage(ArticleListItemViewModel articleData,
      ArticleListItemStyle articleListStyle) {
    return ClipRRect(
      borderRadius: articleListStyle.imageBorderRadius,
      child: NetworkImageFromFuture(articleData.imageUrl, fit: BoxFit.fitWidth),
    );
  }

  //FIXME: Temporal for test ActionBottomSheet
  Future _onMenuPressed(BuildContext context) async {

    // FIXME: This would be injected in the call function. Every screen which need an ActionSheet has to have this CustomActions defined in its view model
    ActionListItemViewModel recordSale = ActionListItemViewModel("Record a new Sale", null, false, icon: "assets/icons/detail_icon_cost.png");
    ActionListItemViewModel recordCost = ActionListItemViewModel("Record a new Cost", null, false, icon: "assets/icons/flag_kenya.png", checkBoxIcon: "assets/icons/radio_button_active.png");
    ActionListItemViewModel testing = ActionListItemViewModel("Record a test", null, true);

    showModalBottomSheet(
        context: context,
        builder: (widgetBuilder) => ActionSheet.build(context, ActionSheetViewModel([recordSale, recordCost, testing], "Cancel"))
    );
  }
}


//ActionSheetViewModel viewModel = ActionSheetViewModel([recordSale, recordCost, testing], "Cancel");
