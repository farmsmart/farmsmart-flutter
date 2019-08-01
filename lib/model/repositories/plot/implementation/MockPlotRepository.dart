
import 'dart:async';
import 'package:farmsmart_flutter/model/model/NewStageEntity.dart';
import 'package:farmsmart_flutter/model/model/PlotEntity.dart';
import 'package:farmsmart_flutter/model/model/PlotInfoEntity.dart';
import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/model/mock/MockPlot.dart';
import 'package:farmsmart_flutter/model/repositories/MockListRepository.dart';
import '../PlotRepositoryInterface.dart';


final _plotBuilder = MockPlotEntity();

class MockPlotRepository extends MockListRepository<PlotEntity> implements PlotRepositoryInterface {

  MockPlotRepository._(IdentifyEntity<PlotEntity> identifyEntity, List<PlotEntity> startData) : super(identifyEntity: identifyEntity, startingData: startData);

  factory MockPlotRepository() {
    final identifyEntity = (PlotEntity plot) {
      return plot.id;
    };
    return MockPlotRepository._(identifyEntity, []);
  }
  @override
  Future<PlotEntity> addPlot({ProfileEntity toProfile, PlotInfoEntity plotInfo, CropEntity crop}) {
    final entity = _plotBuilder.buildWith(crop).then((newPlot){
      return add(newPlot);
    });
    return entity;
  }

  @override
  Future<List<PlotEntity>> getFarm(ProfileEntity forProfile) {
    return getList();
  }

  @override
  Stream<List<PlotEntity>> observeFarm(ProfileEntity forProfile) {
    return observeList();
  }

  @override
  Future<PlotEntity> beginStage(PlotEntity forPlot, NewStageEntity stage) {
    forPlot = _replaceStage(forPlot, stage, _stageWithDates(stage,DateTime.now(),null));
    return Future.value(forPlot);
  }

  @override
  Future<PlotEntity> completeStage(PlotEntity forPlot, NewStageEntity stage) {
    forPlot = _replaceStage(forPlot, stage, _stageWithDates(stage,stage.started,DateTime.now()));
    return Future.value(forPlot);
  }

  @override
  Future<PlotEntity> revertStage(PlotEntity forPlot, NewStageEntity stage) {
    final stageIndex = forPlot.stages.indexOf(stage);
    forPlot = _replaceStage(forPlot, stage, _stageWithDates(stage,stage.started,null));
    for (var i = stageIndex+1; i < forPlot.stages.length; i++) {
      final upcomingStage  = forPlot.stages[i];
      forPlot = _replaceStage(forPlot, upcomingStage, _stageWithDates(upcomingStage,null,null));
    }
    return Future.value(forPlot);
  }

  @override
  Future<PlotEntity> rename(PlotEntity plot, String name) {
    final newPlot = PlotEntity(id: plot.id ,title: name ,crop: plot.crop ,score: plot.score ,stages: plot.stages);
    return replace(plot, newPlot);
  }

  NewStageEntity _stageWithDates(NewStageEntity stage, DateTime start, DateTime end) {
    return  NewStageEntity(id: stage.id, article: stage.article, started: start, ended: end);
  }

  PlotEntity _replaceStage(PlotEntity forPlot, NewStageEntity oldStage, NewStageEntity newStage) {
    final stageIndex = forPlot.stages.indexOf(oldStage);
    var newStages = forPlot.stages;
    newStages.replaceRange(stageIndex,stageIndex+1, [newStage]);
    final newPlot = PlotEntity(id: forPlot.id ,title: forPlot.title ,crop: forPlot.crop ,score: forPlot.score ,stages: newStages);
    replace(forPlot, newPlot);
    return newPlot;
  }
  
}