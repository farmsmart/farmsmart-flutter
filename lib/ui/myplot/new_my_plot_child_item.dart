import 'package:farmsmart_flutter/utils/box_shadows.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';

class MyNewPlotListItem {
  Widget buildListItem() {
    return Padding(
      padding: Paddings.title(),
      child: Row(
        children: <Widget>[
        Padding(
          padding: Paddings.rightPaddingSmall(),
        ),
        Column(
          children: <Widget>[
            Text(
              "BUtton"
            )
          ],
        )],
      ),
    );
  }
}