import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';

class MyNewPlotListItem {
  Widget buildListItem(CropEntity cropsData) {

    const ListCropNameStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(black));
    const ListStatusStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(black));
    const ListDayStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(primaryGreen));

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 30.0, top: 25.0, right: 30.0, bottom: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(cropsData.name, style: ListCropNameStyle)
                    ],
                  ),
                  Row(children: <Widget>[
                    Text("Planting", style: ListStatusStyle)
                  ],
                  ),
                  Row(children: <Widget>[
                    Text("Day 6", style: ListDayStyle)
                  ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  ClipOval(
                    child: NetworkImageFromFuture(
                        cropsData.imageUrl,
                        height: 80.0,
                        width: 80.0,
                        fit: BoxFit.cover
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(child:
        Dividers.listDividerLine()
        ),
      ],
    );
  }
}