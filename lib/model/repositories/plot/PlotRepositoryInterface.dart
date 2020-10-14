
import 'package:farmsmart_flutter/model/entities/StageEntity.dart';
import 'package:farmsmart_flutter/model/entities/PlotEntity.dart';
import 'package:farmsmart_flutter/model/entities/crop_entity.dart';
import 'package:farmsmart_flutter/model/repositories/BasicRepositoryInterface.dart';

abstract class PlotRepositoryInterface implements BasicRepositoryInterface<PlotEntity> {
    Future<List<PlotEntity>> getFarm();
    Stream<List<PlotEntity>> observeFarm();
    Future<PlotEntity> addPlot({Map<String, Map<String,String>> plotInfo, CropEntity crop});
    Future<PlotEntity> completeStage(PlotEntity forPlot, StageEntity stage);
    Future<PlotEntity> beginStage(PlotEntity forPlot, StageEntity stage);
    Future<PlotEntity> revertStage(PlotEntity forPlot, StageEntity stage);
    Future<bool> remove(PlotEntity plot);
    Future<PlotEntity> rename(PlotEntity plot, String name);
}