import 'package:farmsmart_flutter/data/managers/firestore_manager.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/stage_entity.dart';

// Unique source of data access for the plot feature.

class PlotRepository{
  static final PlotRepository _repo = PlotRepository._internal();

  FireStoreManager _firestoreManager;

  static PlotRepository get() {
    return _repo;
  }

  PlotRepository._internal() {
    _firestoreManager = FireStoreManager.get();
  }

  Future<List<CropEntity>> getListOfCrops() {
    return _firestoreManager.getCrops();
  }

  Future<List<CropEntity>> getListOfCropStages(List<CropEntity> cropsWithoutStages) {
    return _firestoreManager.getStages(cropsWithoutStages);
  }

  Future<List<CropEntity>> getListOfCropsWithImages(List<CropEntity> cropsWithoutImages) {
    return _firestoreManager.getCropsImagePath(cropsWithoutImages);
  }

  Future<StageEntity> getListOfStageRelatedArticles(StageEntity stageWithoutRelated) {
    return _firestoreManager.getStageWithRelatedArticles(stageWithoutRelated);
  }

  // Define here the case of use situations "getPlots" "getPlotDetail" and so on.
}