
import 'package:farmsmart_flutter/data/model/NewStageEntity.dart';
import 'package:farmsmart_flutter/data/model/PlotEntity.dart';
import 'package:farmsmart_flutter/data/model/PlotInfoEntity.dart';
import 'package:farmsmart_flutter/data/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/repositories/BasicRepositoryInterface.dart';

abstract class PlotRepositoryInterface implements BasicRepositoryInterface<PlotEntity> {
    Future<List<PlotEntity>> getFarm(ProfileEntity forProfile);
    Stream<List<PlotEntity>> observeFarm(ProfileEntity forProfile);
    Future<PlotEntity> addPlot({ProfileEntity toProfile, PlotInfoEntity plotInfo, CropEntity crop});
    Future<PlotEntity> completeStage(PlotEntity forPlot, NewStageEntity stage);
    Future<PlotEntity> beginStage(PlotEntity forPlot, NewStageEntity stage);
    Future<PlotEntity> revertStage(PlotEntity forPlot, NewStageEntity stage);
}