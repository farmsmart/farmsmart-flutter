import 'package:farmsmart_flutter/model/entities/crop_entity.dart';
import 'StageEntity.dart';

class PlotEntity {
    final String uri;
    final String title;
    final CropEntity crop;
    final double score;
    final List<StageEntity> stages;

  PlotEntity({String uri, String title, CropEntity crop, double score, List<StageEntity> stages}) :  this.uri = uri, this.title = title, this.crop = crop, this.score = score, this.stages = stages;

}