
// TODO this class will manage any plot derived backend logic

class PlotManager {
  static final PlotManager _plotManager = new PlotManager._internal();

  static PlotManager get() {
    return _plotManager;
  }

  PlotManager._internal();
}
