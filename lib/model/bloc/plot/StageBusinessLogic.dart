import 'dart:math';

import 'package:farmsmart_flutter/model/entities/StageEntity.dart';

enum StageStatus {
    upcoming,
    inProgress,
    complete
}

class StageBusinessLogic {

  static final _emptyProgress = 0.05;
  static final _fullProgress = 1.0;

  double progress(List<StageEntity> stages) {
    if (isComplete(stages.last)) {
      return  _fullProgress;
    }
    final currentIndex = currentStageIndex(stages);
    return max(_emptyProgress,currentIndex.toDouble()  / (stages.length).toDouble());
  }

  StageEntity currentStage(List<StageEntity> stages) {
    for (var stage in stages) {
      if (isInProgress(stage) || !isStarted(stage)) {
        return stage;
      }
    }
    return stages.last;
  }

  int currentStageIndex(List<StageEntity> stages) {
    final stage = currentStage(stages);
    for (var i = 0; i < stages.length; i++) {
      if (stages[i] == stage) {
        return i;
      }
    }
    return 0;
  }

  int daysSinceStarted(List<StageEntity> stages) {
    final firstStage = stages.first;
    final lastStage = stages.last;
    final started = firstStage.started;
    final ended = lastStage.ended ?? DateTime.now();
    if (started != null) {
      return ended.difference(started).inDays;
    }
    return 0;
  }

  StageStatus status(StageEntity stage) {
    if(isInProgress(stage)) {
        return StageStatus.inProgress;
    }
    else if (isComplete(stage)) {
        return StageStatus.complete;
    }
    return StageStatus.upcoming;
  }

  StageEntity nextStage(StageEntity stage, List<StageEntity> stages) {
    bool next = false;
    for (var stageEntry in stages) {
      if(next){
        return stageEntry;
      }
      else if(stageEntry == stage){
        next = true;
      }
    }
    return null;
  }

  StageEntity prevStage(StageEntity stage, List<StageEntity> stages) {
    return nextStage(stage, stages.reversed.toList());
  }


  bool isInProgress(StageEntity stage) {
    if (stage == null) {
      return false;
    }
    return isStarted(stage) && !isComplete(stage);
  }

  bool isStarted(StageEntity stage) {
    if (stage == null) {
      return false;
    }
    return (stage.started  != null) && stage.started.isBefore(DateTime.now());
  }

  bool isComplete(StageEntity stage) {
    if (stage == null) {
      return false;
    }
    return (stage.ended != null) && stage.ended.isBefore(DateTime.now());
  }

  bool canComplete(StageEntity stage, List<StageEntity> stages) {
      return isInProgress(stage);
  }

  bool canBegin(StageEntity stage, List<StageEntity> stages) {
    if (stage == null) {
      return false;
    }
    if (stage == stages.first)
    {
      return !isStarted(stage);
    }
    return isComplete(prevStage(stage, stages)) && !isStarted(stage);
  }

  bool canRevert(StageEntity stage, List<StageEntity> stages) {
    final next = nextStage(stage, stages);
    if (next == null){
      return isComplete(stage);
    }
    return isComplete(stage) && (canBegin(next, stages) || isInProgress(next));
  }

  
  
}