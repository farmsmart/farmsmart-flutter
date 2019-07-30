
import 'dart:async';
import 'dart:math';
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
  final _rand = Random(0);
  final _errorOneIn = 100;
  final _plotStreamController =  StreamController<List<PlotEntity>>.broadcast(); 
  List<PlotEntity> _plots = [];

  var _observers = Map<String,StreamController<PlotEntity> >();   

  @override
  Future<PlotEntity> addPlot({ProfileEntity toProfile, PlotInfoEntity plotInfo, CropEntity crop}) {
    final entity = _plotBuilder.buildWith(crop).then((newPlot){
      _plots.add(newPlot);
      _update();
      return newPlot;
    });
   
    return entity;
  }

  @override
  Future<List<PlotEntity>> getCollection(EntityCollection<PlotEntity> collection) {
    return collection.getEntities();
  }

  @override
  Future<List<PlotEntity>> getFarm(ProfileEntity forProfile) {
    int errorChance = _rand.nextInt(_errorOneIn);
    _update();
    return (errorChance == 0) ? Future.error(Error()) : Future.value(_plots);
  }

  @override
  Future<PlotEntity> getSingle(String uri) {
    final plotEntity = _plots.singleWhere((plotEntity) => plotEntity.id == uri, orElse: () => null);
    return plotEntity != null ? Future.value(plotEntity) : Future.error(Error());
  }

  @override
  Stream<PlotEntity> observe(String uri) {
    final controller = _observers[uri];
    if(controller == null){
      _observers[uri] = StreamController<PlotEntity>.broadcast();
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

  @override
  Future<bool> remove(PlotEntity plot) {
    _plots.remove(plot);
    _update();
    return  Future.value(true);
  }

  @override
  Future<PlotEntity> rename(PlotEntity plot, String name) {
     final plotIndex = _plots.indexOf(plot);
    final newPlot = PlotEntity(id: plot.id ,title: name ,crop: plot.crop ,score: plot.score ,stages: plot.stages);
    _plots.replaceRange(plotIndex, plotIndex+1, [newPlot]);
    _update();
    return  Future.value(newPlot);
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