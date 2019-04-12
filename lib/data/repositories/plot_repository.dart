import 'package:farmsmart_flutter/data/managers/plot_manager.dart';

// Unique source of data access for the plot feature.

class PlotRepository{
  static final PlotRepository _repo = new PlotRepository._internal();

  PlotManager _plotManager;

  static PlotRepository get() {
    return _repo;
  }

  PlotRepository._internal() {
    _plotManager = PlotManager.get();
  }

  // Define here the case of use situations "getPlots" "getPlotDetail" and so on.

}