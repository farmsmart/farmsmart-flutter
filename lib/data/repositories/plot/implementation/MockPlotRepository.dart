
import 'dart:async';

import 'package:farmsmart_flutter/data/model/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/data/model/PlotEntity.dart';
import 'package:farmsmart_flutter/data/model/PlotInfoEntity.dart';
import 'package:farmsmart_flutter/data/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/mock/MockPlot.dart';
import '../PlotRepositoryInterface.dart';


final _plotBuilder = MockPlotEntity();

class MockPlotRepository implements PlotRepositoryInterface {
  final _plotStreamController =  StreamController<List<PlotEntity>>.broadcast(); 
  List<PlotEntity> _plots = [];

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