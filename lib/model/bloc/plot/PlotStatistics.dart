import 'package:farmsmart_flutter/model/entities/PlotEntity.dart';

import 'StageBusinessLogic.dart';

class PlotStatistics {

  StageBusinessLogic _stageLogic = StageBusinessLogic();

  int compeletedCount(List<PlotEntity> plots) {
    int completed = 0;
    plots.forEach((plot){
      completed += _stageLogic.isComplete(plot.stages.last)? 1:0;
    });
    return completed;
  }

  int activeCount(List<PlotEntity> plots) {
     int completed = 0;
    plots.forEach((plot){
      bool active = _stageLogic.isStarted(plot.stages.first) && !_stageLogic.isComplete(plot.stages.last);
      completed += active ? 1:0;
    });
    return completed;
  }

}