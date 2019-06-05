import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/stage_entity.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../app_bar.dart';
import 'myplot_viewmodel.dart';

class MyPlotCurrentStageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CurrentStageState();
  }
}

class _CurrentStageState extends State<MyPlotCurrentStageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, MyPlotViewModel>(
          builder: (_, viewModel) => _buildBody(context, viewModel, viewModel.selectedStage, viewModel.selectedStage.crop),
          converter: (store) => MyPlotViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, MyPlotViewModel viewModel, StageEntity stageData, String cropTitle) {
    return Scaffold(
        appBar: CustomAppBar.buildForDetail(cropTitle),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: Paddings.boxSmallPadding(),
                    child: Text(stageData.name,
                        style: Styles.detailTitleTextStyle())),
                Padding(
                    padding: Paddings.boxSmallPadding(),
                    child: Html(data: stageData.content)),
                Padding(
                  padding: Paddings.boxSmallPadding(),
                  child: Text("Related Articles", style: Styles.titleTextStyle()),
                ),
                buildRelated(context, viewModel, stageData.stageRelatedArticles)
              ],
            )));
  }
}

Widget buildRelated(BuildContext context, MyPlotViewModel viewModel, List<ArticleEntity> articlesList) {
  return Column(
      children: (articlesList != null) ? (articlesList.map((article) =>
          buildListOfRelatedArticles(article, viewModel)).toList()) : null);
}

Widget buildListOfRelatedArticles(ArticleEntity articleData, MyPlotViewModel viewModel) {
  return GestureDetector(
      onTap: () {
        viewModel.goToRelatedArticleDetail(articleData);
      },
      child: Padding(
        key: ValueKey(articleData.title ?? Strings.noTitleString),
        padding: Paddings.listOfArticlesPadding(),
        child: Container(
            height: listItemHeight,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildListItemImage(articleData),
                    Padding(
                      padding: Paddings.leftPaddingSmall(),
                    ),
                    _buildArticleTitle(articleData),
                    _buildListIcon(),
                    Padding(
                      padding: Paddings.rightPaddingSmall(),
                    ),
                  ],
                ),
                Padding(
                  padding: Paddings.bottomPaddingSmall(),
                ),
                Dividers.listDividerLine(),
              ],
            )),
      ));
}


_buildListItemImage(ArticleEntity articleData) {
  return FadeInImage.assetNetwork(
      image: articleData.imageUrl,
      placeholder: Assets.IMAGE_PLACE_HOLDER,
      height: 90,
      width: 140,
      fit: BoxFit.cover);
}

_buildArticleTitle(ArticleEntity articleData) {
  return Expanded(
    flex: listViewFlex,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(articleData.title ?? Strings.noTitleString,
            maxLines: titleMaxLines,
            overflow: TextOverflow.ellipsis,
            style: Styles.articleListTitleStyle()),
        Margins.generalListSmallerMargin(),
        Text(articleData.summary ?? Strings.myPlotItemDefaultTitle,
            maxLines: summaryMaxLines,
            overflow: TextOverflow.ellipsis,
            style: Styles.footerTextStyle()),
      ],
    ),
  );
}

_buildListIcon() {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Icon(
          Icons.arrow_forward_ios,
          size: arrowIconSize,
          color: Color(primaryGrey),
        ),
      ],
    ),
  );
}
