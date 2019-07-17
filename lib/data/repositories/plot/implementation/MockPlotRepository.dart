
import 'dart:async';

import 'package:farmsmart_flutter/data/bloc/plot/StageBusinessLogic.dart';
import 'package:farmsmart_flutter/data/model/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/data/model/NewStageEntity.dart';
import 'package:farmsmart_flutter/data/model/PlotEntity.dart';
import 'package:farmsmart_flutter/data/model/PlotInfoEntity.dart';
import 'package:farmsmart_flutter/data/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/mock/MockPlot.dart';
import '../PlotRepositoryInterface.dart';


final _plotBuilder = MockPlotEntity();

class MockPlotRepository implements PlotRepositoryInterface {
  final StageBusinessLogic _stageLogic =  StageBusinessLogic() ;
  final _plotStreamController =  StreamController<List<PlotEntity>>.broadcast(); 
  List<PlotEntity> _plots = [];

  var _observers = Map<String,StreamController<PlotEntity> >();   

  @override
  Future<PlotEntity> addPlot({ProfileEntity toProfile, PlotInfoEntity plotInfo, CropEntity crop}) {
    final entity = _plotBuilder.build();
    _plots.add(entity);
    _update();
    return Future.value(entity);
  }

  @override
  Future<List<PlotEntity>> getCollection(EntityCollection<PlotEntity> collection) {
    return collection.getEntities();
  }

  @override
  Future<List<PlotEntity>> getFarm(ProfileEntity forProfile) {
    return Future.value(_plots);
  }

  @override
  Future<PlotEntity> getSingle(String uri) {
    for (var i = 0; i < _plots.length; i++) {
      if(_plots[i].id == uri){
        return Future.value(_plots[i]);
      }
    }
    return Future.error(Error());
  }

  @override
  Stream<PlotEntity> observe(String uri) {
    final controller = _observers[uri];
    if(controller == null){
      final newController = StreamController<PlotEntity>.broadcast();
      _observers[uri] = newController;
    }
    return _observers[uri].stream;
  }

  @override
  Stream<List<PlotEntity>> observeFarm(ProfileEntity forProfile) {
    return _plotStreamController.stream;
  }

  void _update() {
    _plotStreamController.sink.add(_plots);

    //LH update any observers of the plots 
    for (var plot in _plots) {
      final controller = _observers[plot.id];
      if (controller != null) {
        controller.sink.add(plot);
      }
    }
  }

  void dispose(){
    _plotStreamController.sink.close();
    _plotStreamController.close();
    for (var controller in _observers.values ) {
      controller.sink.close();
      controller.close();
    }
  }

  @override
  Future<PlotEntity> beginStage(PlotEntity forPlot, NewStageEntity stage) {
    forPlot = _replaceStage(forPlot, stage, _stageWithDates(stage,DateTime.now(),null));
    _update();
    return Future.value(forPlot);
  }

  @override
  Future<PlotEntity> completeStage(PlotEntity forPlot, NewStageEntity stage) {
    forPlot = _replaceStage(forPlot, stage, _stageWithDates(stage,stage.started,DateTime.now()));
     _update();
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
    _update();
    return Future.value(forPlot);
  }


   NewStageEntity _stageWithDates(NewStageEntity stage, DateTime start, DateTime end) {
    return  NewStageEntity(id: stage.id, article: stage.article, started: start, ended: end);
  }

  PlotEntity _replaceStage(PlotEntity forPlot, NewStageEntity oldStage, NewStageEntity newStage) {
    final stageIndex = forPlot.stages.indexOf(oldStage);
    final plotIndex = _plots.indexOf(forPlot);
    var newStages = forPlot.stages;
    newStages.replaceRange(stageIndex,stageIndex+1, [newStage]);
    final newPlot = PlotEntity(id: forPlot.id ,title: forPlot.title ,crop: forPlot.crop ,score: forPlot.score ,stages: newStages);
    _plots.replaceRange(plotIndex, plotIndex+1, [newPlot]);
    return newPlot;
  }
  
}