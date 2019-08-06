
import 'dart:async';
import 'package:farmsmart_flutter/model/model/FactorEntity.dart';
import 'package:farmsmart_flutter/model/model/StageEntity.dart';
import 'package:farmsmart_flutter/model/model/PlotEntity.dart';
import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/model/mock/MockPlot.dart';
import 'package:farmsmart_flutter/model/repositories/MockListRepository.dart';
import '../PlotRepositoryInterface.dart';


final _plotBuilder = MockPlotEntity();

class MockPlotRepository extends MockListRepository<PlotEntity> implements PlotRepositoryInterface {

  MockPlotRepository._(IdentifyEntity<PlotEntity> identifyEntity, List<PlotEntity> startData,) : super(identifyEntity: identifyEntity, startingData: startData);

  factory MockPlotRepository() {
    final identifyEntity = (PlotEntity plot) {
      return plot.id;
    };
    return MockPlotRepository._(identifyEntity, []);
  }
  @override
  Future<PlotEntity> addPlot({ProfileEntity toProfile, FactorEntity factorInput, CropEntity crop}) {
    final entity = _plotBuilder.buildWith(crop).then((newPlot){
      return add(newPlot);
    });
    return entity;
  }

  @override
  Future<List<PlotEntity>> getFarm() {
    return getList();
  }

  @override
  Stream<List<PlotEntity>> observeFarm() {
    return observeList();
  }

  @override
  Future<PlotEntity> beginStage(PlotEntity forPlot, StageEntity stage) {
    forPlot = _replaceStage(forPlot, stage, _stageWithDates(stage,DateTime.now(),null));
    return Future.value(forPlot);
  }

  @override
  Future<PlotEntity> completeStage(PlotEntity forPlot, StageEntity stage) {
    forPlot = _replaceStage(forPlot, stage, _stageWithDates(stage,stage.started,DateTime.now()));
    return Future.value(forPlot);
  }

  @override
  Future<PlotEntity> revertStage(PlotEntity forPlot, StageEntity stage) {
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

  StageEntity _stageWithDates(StageEntity stage, DateTime start, DateTime end) {
    return  StageEntity(id: stage.id, article: stage.article, started: start, ended: end);
  }

  PlotEntity _replaceStage(PlotEntity forPlot, StageEntity oldStage, StageEntity newStage) {
    final stageIndex = forPlot.stages.indexOf(oldStage);
    var newStages = forPlot.stages;
    newStages.replaceRange(stageIndex,stageIndex+1, [newStage]);
    final newPlot = PlotEntity(id: forPlot.id ,title: forPlot.title ,crop: forPlot.crop ,score: forPlot.score ,stages: newStages);
    replace(forPlot, newPlot);
    return newPlot;
  }
  
}