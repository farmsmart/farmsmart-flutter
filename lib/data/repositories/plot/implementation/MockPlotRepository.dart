
import 'dart:async';

import 'package:farmsmart_flutter/data/model/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/data/model/PlotEntity.dart';
import 'package:farmsmart_flutter/data/model/PlotInfoEntity.dart';
import 'package:farmsmart_flutter/data/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/mock/MockStage.dart';
import 'package:farmsmart_flutter/data/repositories/crop/implementation/MockCropRepository.dart';
import 'package:farmsmart_flutter/ui/profitloss/mockRepositoryTryout/MockString.dart';
import '../PlotRepositoryInterface.dart';

MockString _identifiers = MockString();
MockStage _mockStage = MockStage();
MockString _titles = MockString(library: ["TEA", "Sugarcane","Maize", "Mirra", "PYRETHRUM" , "Coffee" ]);

class MockPlotEntity {
   static PlotEntity build() {
    final entity = PlotEntity(id: _identifiers.identifier(), title: _titles.random(), crop: MockCrop.build(), score: 0.5, stages: _mockStage.list());
    return entity;
  }
  
  static List<PlotEntity> list({int count = 50}) {
    List<PlotEntity> plots = [];
    for (var i = 0; i < count; i++) {
      plots.add(build());
    }
    return plots;
  }
}

class MockPlotRepository implements PlotRepositoryInterface {
  final _plotStreamController =  StreamController<List<PlotEntity>>.broadcast(); 
  List<PlotEntity> _plots = [];

  @override
  Future<PlotEntity> addPlot({ProfileEntity toProfile, PlotInfoEntity plotInfo, CropEntity crop}) {
    final entity = MockPlotEntity.build();
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
    // TODO: implement getSingle
    return null;
  }

  @override
  Stream<PlotEntity> observe(String uri) {
    // TODO: implement observe
    return null;
  }

  @override
  Stream<List<PlotEntity>> observeFarm(ProfileEntity forProfile) {
    return _plotStreamController.stream;
  }

  void _update() {
    _plotStreamController.sink.add(_plots);
  }

  void dispose(){
    _plotStreamController.close();
  }
  
}