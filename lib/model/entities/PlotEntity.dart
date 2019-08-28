import 'package:farmsmart_flutter/model/entities/crop_entity.dart';
import 'StageEntity.dart';

class PlotEntity {
    final String id;
    final String title;
    final CropEntity crop;
    final double score;
    final List<StageEntity> stages;

  PlotEntity({String id, String title, CropEntity crop, double score, List<StageEntity> stages}) :  this.id = id, this.title = title, this.crop = crop, this.score = score, this.stages = stages;

}