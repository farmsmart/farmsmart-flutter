import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:flutter/material.dart';

class MyPlotListItem {
  Widget buildListItem(CropEntity cropsData, goToDetail) {
    return GestureDetector(
        onTap: () {
          goToDetail(cropsData);
        },
        child: Padding(
            key: ValueKey(cropsData.name ?? "No Title"),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(cropsData.name ?? "No Title")));
  }
}
