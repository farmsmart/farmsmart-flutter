import 'dart:math';

import 'package:farmsmart_flutter/data/model/NewStageEntity.dart';

enum StageStatus {
    upcoming,
    inProgress,
    complete
}

class StageBusinessLogic {

  double progress(List<NewStageEntity> stages) {
    if (isComplete(stages.last)) {
      return  1.0;
    }
    final currentIndex = currentStageIndex(stages);
    return max(0.05,currentIndex.toDouble()  / (stages.length).toDouble());
  }

  NewStageEntity currentStage(List<NewStageEntity> stages) {
    for (var stage in stages) {
      if (isInProgress(stage) || !isStarted(stage)) {
        return stage;
      }
    }
    return stages.last;
  }

  int currentStageIndex(List<NewStageEntity> stages) {
    final stage = currentStage(stages);
    for (var i = 0; i < stages.length; i++) {
      if (stages[i] == stage) {
        return i;
      }
    }
    return 0;
  }

  int daysSinceStarted(List<NewStageEntity> stages) {
    final firstStage = stages.first;
    final started = firstStage.started;
    if (started != null) {
       return DateTime.now().difference(started).inDays;
    }
    return 0;
  }

  StageStatus status(NewStageEntity stage) {
    if(isInProgress(stage)) {
        return StageStatus.inProgress;
    }
    else if (isComplete(stage)) {
        return StageStatus.complete;
    }
    return StageStatus.upcoming;
  }

  bool isInProgress(NewStageEntity stage) {
    return isStarted(stage) && !isComplete(stage);
  }

  bool isStarted(NewStageEntity stage) {
    return (stage.started  != null) && stage.started.isBefore(DateTime.now());
  }

  bool isComplete(NewStageEntity stage) {
    return (stage.ended  != null) && stage.ended.isBefore(DateTime.now());
  }

  bool canComplete(NewStageEntity stage, List<NewStageEntity> stages) {
      return isInProgress(stage);
  }

  bool canBegin(NewStageEntity stage, List<NewStageEntity> stages) {
    final index = stages.indexOf(stage);
    if (index <= 0)
    {
      return !isStarted(stage);
    }
    final prevStage = stages[index-1];
    return isComplete(prevStage) && !isStarted(stage);
  }
  
}