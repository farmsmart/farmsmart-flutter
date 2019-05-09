import 'package:farmsmart_flutter/model/crop_detail_property.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class MyPlotDetailProperties {
  Widget build(List<CropDetailProperty> cropProperties) {
    return
      ExpansionTile(
          initiallyExpanded: true,
          title: Text(Strings.myPlotDetailPropertiesTitle,
              style: Styles.detailTitleTextStyle()),
          children: (cropProperties
              .map((cropProperty) => buildPropertyItem(cropProperty)))
              .toList());
  }

  Widget buildPropertyItem(CropDetailProperty cropProperty) {
    return Padding(
        padding: Margins.sidesPadding(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(cropProperty.title, style: Styles.detailSubtitleTextStyle()),
              Margins.generalListSmallMargin(),
              Text(cropProperty.properties),
              Margins.generalListSmallMargin(),
              Divider(height: 4, color: Color(black)),
              Margins.generalListMargin(),
            ])
    );
  }
}
