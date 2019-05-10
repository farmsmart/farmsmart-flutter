import 'package:farmsmart_flutter/data/model/stage.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
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
          builder: (_, viewModel) => _buildBody(
              context, viewModel.selectedStage, viewModel.selectedStage.crop),
          converter: (store) => MyPlotViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, Stage stageData, String cropTitle) {
    return Scaffold(
        appBar: CustomAppBar.buildForDetail(cropTitle),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: Paddings.boxSmallPadding(),
                child: Text(stageData.name,
                    style: Styles.detailTitleTextStyle())),
            Padding(
                padding: Paddings.boxSmallPadding(),
                child: Html(data: stageData.content)),
          ],
        ));
  }
}

//
