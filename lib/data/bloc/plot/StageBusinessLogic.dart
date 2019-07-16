import 'package:farmsmart_flutter/data/model/NewStageEntity.dart';

enum StageStatus {
    upcoming,
    inProgress,
    complete
}

class StageBusinessLogic {
  NewStageEntity currentStage(List<NewStageEntity> stages) {
    for (var item in stages) {
      if (item.started != null && item.ended == null) {
        return item;
      }
    }
    return (stages.last.ended != null ) ? stages.last : stages.first;
  }

  int currentStageIndex(List<NewStageEntity> stages) {
    final stage = currentStage(stages);
    for (var i = 0; i < stages.length; i++) {
      if (stages[i]  == stage) {
        return i;
      }
    }
    return 0;
  }

  StageStatus status(NewStageEntity stage) {
    if(isComplete(stage)) {
        return StageStatus.complete;
    }
    else if (isStarted(stage)) {
        return StageStatus.inProgress;
    }
    return StageStatus.upcoming;
  }

  bool isStarted(NewStageEntity stage) {
    return (stage.started  != null) && stage.started.isBefore(DateTime.now());
  }

  bool isComplete(NewStageEntity stage) {
    return (stage.ended  != null) && stage.ended.isBefore(DateTime.now());
  }
  
}