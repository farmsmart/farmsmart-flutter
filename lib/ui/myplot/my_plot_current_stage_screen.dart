import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/stage_entity.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/common/content_webview.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/ui/common/related_article.dart';
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

  GlobalKey<State<Scaffold>> scaffold = GlobalKey<State<Scaffold>>();

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
        key: scaffold,
        appBar: CustomAppBar.buildForDetail(cropTitle),
        persistentFooterButtons: RelatedArticle.buildRelatedArticlesFooter(scaffold, stageData, viewModel.goToRelatedArticleDetail),
        body: ContentWebView(htmlContent: stageData.content),
    );
  }
}


