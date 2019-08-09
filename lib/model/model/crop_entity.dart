import 'package:farmsmart_flutter/model/model/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/model/model/ImageEntity.dart';
import 'package:farmsmart_flutter/model/model/ImageURLProvider.dart';
import 'package:farmsmart_flutter/model/model/article_entity.dart';

import 'enums.dart';

class CropEntity {
  String id;
  List<String> companionPlants;
  CropComplexity complexity;
  List<String> cropsInRotation;
  CropType cropType;
  String name;
  List<String> nonCompanionPlants;
  LoHi profitability;
  LoHi setupCost;
  List<String> soilType;
  Status status;
  LoHi waterRequirement;
  ArticleEntity article;
  EntityCollection<ArticleEntity> stageArticles;
  EntityCollection<ImageEntity> images;

  CropEntity({
    this.id,
    this.article,
    this.companionPlants = const [],
    this.complexity,
    this.cropsInRotation = const [],
    this.cropType,
    this.name,
    this.nonCompanionPlants = const [],
    this.profitability,
    this.setupCost,
    this.soilType = const [],
    this.status,
    this.waterRequirement,
  });

}

// LH this is to make getting the main crop image easier
class CropImageProvider implements ImageURLProvider {
  final CropEntity _crop;
  CropImageProvider(CropEntity crop) : _crop = crop;
  @override
  Future<String> urlToFit({double width, double height}) {
    if ( _crop.images == null)
    {
      return Future.value(null);
    }
    return _crop.images.getEntities(limit: 1).then((imageEntities) {
      // NB: we assume the first image is the hero
      return imageEntities.first.urlProvider.urlToFit(width: width,height: height);
    });
  }
}
