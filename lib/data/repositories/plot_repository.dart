import 'package:farmsmart_flutter/data/managers/firestore_manager.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/stage_entity.dart';
import 'package:flutter/foundation.dart';

// Unique source of data access for the plot feature.

class PlotRepository {
  static final PlotRepository _repo = PlotRepository._internal();

  FireStoreManager _firestoreManager;

  static PlotRepository get() {
    return _repo;
  }

  PlotRepository._internal() {
    _firestoreManager = FireStoreManager.get();
  }

  Future<List<CropEntity>> _getListOfCrops() {
    return _firestoreManager.getCrops();
  }

  Future<dynamic> _getListOfCropStagesForCrop(CropEntity cropEntity) {
    return _firestoreManager.getStagesForCrop(cropEntity);
  }

  /// Adds images to the supplied crop entities
  Future<dynamic> _getListOfCropsWithImages(
      List<CropEntity> cropsWithoutImages) {
    return _firestoreManager.getCropsImagePath(cropsWithoutImages);
  }

  Future<List<CropEntity>> getArticles() async {
    Stopwatch sw = new Stopwatch();
    sw.start();
    List<CropEntity> listOfCrops = await _getListOfCrops();
    debugPrint('getListOfCrops() ${sw.elapsed.inMilliseconds} ms ');
    sw.reset();

    Future stages = Future.wait(
        listOfCrops.map((crop) => _getListOfCropStagesForCrop(crop)).toList());
    Future images = _getListOfCropsWithImages(listOfCrops);
    await Future.wait([stages, images]);
    debugPrint('getStagesAndImages() ${sw.elapsed.inMilliseconds} ms ');
    sw.stop();
    debugPrint('Fetch crop complete.');

    return listOfCrops;
  }

  // Define here the case of use situations "getPlots" "getPlotDetail" and so on.
}
