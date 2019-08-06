
import 'package:farmsmart_flutter/model/model/FactorEntity.dart';
import 'package:farmsmart_flutter/model/model/StageEntity.dart';
import 'package:farmsmart_flutter/model/model/PlotEntity.dart';
import 'package:farmsmart_flutter/model/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/repositories/BasicRepositoryInterface.dart';

abstract class PlotRepositoryInterface implements BasicRepositoryInterface<PlotEntity> {
    Future<List<PlotEntity>> getFarm();
    Stream<List<PlotEntity>> observeFarm();
    Future<PlotEntity> addPlot({FactorEntity factorInput, CropEntity crop});
    Future<PlotEntity> completeStage(PlotEntity forPlot, StageEntity stage);
    Future<PlotEntity> beginStage(PlotEntity forPlot, StageEntity stage);
    Future<PlotEntity> revertStage(PlotEntity forPlot, StageEntity stage);
    Future<bool> remove(PlotEntity plot);
    Future<PlotEntity> rename(PlotEntity plot, String name);
}