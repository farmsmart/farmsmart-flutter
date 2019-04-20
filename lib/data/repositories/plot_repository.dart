import 'package:farmsmart_flutter/data/managers/firestore_manager.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';

// Unique source of data access for the plot feature.

class PlotRepository{
  static final PlotRepository _repo = new PlotRepository._internal();

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

  // Define here the case of use situations "getPlots" "getPlotDetail" and so on.

}