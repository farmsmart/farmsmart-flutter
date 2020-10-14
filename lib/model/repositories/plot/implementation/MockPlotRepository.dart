
import 'dart:async';
import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/model/entities/StageEntity.dart';
import 'package:farmsmart_flutter/model/entities/PlotEntity.dart';
import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/entities/crop_entity.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockPlot.dart';
import 'package:farmsmart_flutter/model/repositories/MockListRepository.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import '../PlotRepositoryInterface.dart';

/*
  The mock profile is quite complex, it needs to have a list of different farms per profile
*/
final _plotBuilder = MockPlotEntity();

class MockPlotRepository implements PlotRepositoryInterface {

  final ProfileRepositoryInterface _profileRepository;
  final IdentifyEntity<PlotEntity> _identifyEntity;
  final _streamController = StreamController<List<PlotEntity>>.broadcast();
  final _streamforObservers = StreamController<PlotEntity>.broadcast();
  Map<String,MockListRepository<PlotEntity>> _listRepos = {}; 

  MockPlotRepository._(ProfileRepositoryInterface profileRepository, IdentifyEntity<PlotEntity> identifyEntity, List<PlotEntity> startData,):  this._profileRepository = profileRepository, this._identifyEntity = identifyEntity;

  factory MockPlotRepository(ProfileRepositoryInterface profileRepository) {
    final identifyEntity = (PlotEntity plot) {
      return plot.uri;
    };
    return MockPlotRepository._(profileRepository,identifyEntity, []);
  }
  @override
  Future<PlotEntity> addPlot({ProfileEntity toProfile, Map<String,Map<String,String>> plotInfo, CropEntity crop}) {
    return _plotBuilder.buildWith(crop).then((newPlot){
      return _profileRepository.getCurrent().then((profile) {
        
        return _listFor(profile.uri).add(newPlot); 
      });
    });
  }

  @override
  Future<List<PlotEntity>> getFarm() {
     return _profileRepository.getCurrent().then((profile) {
       return _listFor(profile.uri).getList();
     });
  }

  @override
  Stream<List<PlotEntity>> observeFarm() {
     return _streamController.stream;
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
    final newPlot = PlotEntity(uri: plot.uri ,title: name ,crop: plot.crop ,score: plot.score ,stages: plot.stages);
    return replace(plot, newPlot);
  }

  StageEntity _stageWithDates(StageEntity stage, DateTime start, DateTime end) {
    return  StageEntity(id: stage.id, article: stage.article, started: start, ended: end);
  }

  PlotEntity _replaceStage(PlotEntity forPlot, StageEntity oldStage, StageEntity newStage) {
    final stageIndex = forPlot.stages.indexOf(oldStage);
    var newStages = forPlot.stages;
    newStages.replaceRange(stageIndex,stageIndex+1, [newStage]);
    final newPlot = PlotEntity(uri: forPlot.uri ,title: forPlot.title ,crop: forPlot.crop ,score: forPlot.score ,stages: newStages);
    replace(forPlot, newPlot);
    return newPlot;
  }

  @override
  Future<List<PlotEntity>> getCollection(EntityCollection<PlotEntity> collection) {
    return collection.getEntities();
  }

  @override
  Future<PlotEntity> getSingle(String uri) {
     return _profileRepository.getCurrent().then((profile) {
       return _listFor(profile.uri).getSingle(uri);
     });
  }

  @override
  Stream<PlotEntity> observeSingle(String uri) {
    final streamTransformer = StreamTransformer<PlotEntity,PlotEntity>.fromHandlers(handleData: (input, sink) {
        if(input.uri== uri){
          return sink.add(input);
        }
      }); 
    return _streamforObservers.stream.transform(streamTransformer);
  }

  @override
  Future<bool> remove(PlotEntity plot) {
     return _profileRepository.getCurrent().then((profile) {
       return _listFor(profile.uri).remove(plot);
     });
  }

  Future<PlotEntity> replace(PlotEntity oldObject, PlotEntity newObject) {
     return _profileRepository.getCurrent().then((profile) {
       return _listFor(profile.uri).replace(oldObject,newObject);
     });
  }

  MockListRepository<PlotEntity> _listFor(String id) {
     if(_listRepos[id] == null) {
          _listRepos[id] = MockListRepository<PlotEntity>(identifyEntity: _identifyEntity,startingData: []);
          _listRepos[id].observeList().listen((plots){
              _update(id:id, plots:plots);
          });
          _listRepos[id].getList();
    }
    return _listRepos[id];
  }

  void _update({String id, List<PlotEntity> plots}) {
    _profileRepository.getCurrent().then((currentProfile) {
        if(currentProfile.uri  == id) {
          for (var plot in plots) {
            _streamforObservers.sink.add(plot);
          }
          _streamController.sink.add(plots);
        }
    });
  }

  void dispose() {
    _streamController.sink.close();
    _streamController.close();
    _streamforObservers.sink.close();
    _streamforObservers.close();
  }
  
}