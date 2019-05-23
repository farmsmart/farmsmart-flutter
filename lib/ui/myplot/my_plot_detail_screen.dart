import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/crop_detail_property.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/utils/styles.dart';

import '../app_bar.dart';
import 'my_plot_detail_properties.dart';
import 'my_plot_detail_stages.dart';
import 'myplot_viewmodel.dart';

class CropDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CropDetailState();
  }
}

class _CropDetailState extends State<CropDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, MyPlotViewModel>(
          builder: (_, viewModel) => _buildBody(context, viewModel.selectedCrop,
              viewModel.getCropDetailProperties(viewModel.selectedCrop), viewModel.goToStage),
          converter: (store) => MyPlotViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, CropEntity selectedCropData,
      List<CropDetailProperty> cropDetailProperties, goToStageDetail) {
    String deepLink;
    return Scaffold(
        appBar: CustomAppBar.buildForDetail(selectedCropData.name, CustomAppBar.shareAction(deepLink)),
        body: Container(
            decoration: BoxDecoration(
              color: Color(white),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListView(children: <Widget>[
              FadeInImage.assetNetwork(
                  image: selectedCropData.imageUrl,
                  height: listImageHeight,
                  width: listImageWidth,
                  placeholder: Assets.IMAGE_PLACE_HOLDER,
                  fit: BoxFit.fitWidth),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: Paddings.boxPadding(),
                      child: Text(selectedCropData.summary,
                          style: Styles.descriptionTextStyle())),
                  Margins.generalListMargin(),
                  Html(data: selectedCropData.content),
                  MyPlotDetailProperties().build(cropDetailProperties, context),
                  Padding(
                      padding: Paddings.boxPadding(),
                      child: Text(Strings.myPlotDetailStepByStepTitle, style: Styles.detailTitleTextStyle()),),
                  MyPlotDetailStages().build(selectedCropData.stages, goToStageDetail)
                ],
              ),
            ])));
  }
}
