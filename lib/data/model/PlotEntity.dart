import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'NewStageEntity.dart';

class PlotEntity {
    final String id;
    final String title;
    final CropEntity crop;
    final double score;
    final List<NewStageEntity> stages;

  PlotEntity({String id, String title, CropEntity crop, double score, List<NewStageEntity> stages}) :  this.id = id, this.title = title, this.crop = crop, this.score = score, this.stages = stages;

}