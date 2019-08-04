
import 'package:farmsmart_flutter/model/model/StageEntity.dart';
import 'package:farmsmart_flutter/model/model/PlotEntity.dart';
import 'package:farmsmart_flutter/model/model/PlotInfoEntity.dart';
import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/repositories/BasicRepositoryInterface.dart';

abstract class PlotRepositoryInterface implements BasicRepositoryInterface<PlotEntity> {
    Future<List<PlotEntity>> getFarm(ProfileEntity forProfile);
    Stream<List<PlotEntity>> observeFarm(ProfileEntity forProfile);
    Future<PlotEntity> addPlot({ProfileEntity toProfile, PlotInfoEntity plotInfo, CropEntity crop});
    Future<PlotEntity> completeStage(PlotEntity forPlot, StageEntity stage);
    Future<PlotEntity> beginStage(PlotEntity forPlot, StageEntity stage);
    Future<PlotEntity> revertStage(PlotEntity forPlot, StageEntity stage);
    Future<bool> remove(PlotEntity plot);
    Future<PlotEntity> rename(PlotEntity plot, String name);
}