import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'NewStageEntity.dart';

class PlotEntity {
    final String id;
    final CropEntity crop;
    final double score;
    final List<NewStageEntity> stages;

  PlotEntity({String id, CropEntity crop, double score, List<NewStageEntity> stages}) :  this.id = id, this.crop = crop, this.score = score, this.stages = stages;

}