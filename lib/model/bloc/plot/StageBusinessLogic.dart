import 'dart:math';

import 'package:farmsmart_flutter/model/model/NewStageEntity.dart';

enum StageStatus {
    upcoming,
    inProgress,
    complete
}

class StageBusinessLogic {

  static final _emptyProgress = 0.05;
  static final _fullProgress = 1.0;

  double progress(List<NewStageEntity> stages) {
    if (isComplete(stages.last)) {
      return  _fullProgress;
    }
    final currentIndex = currentStageIndex(stages);
    return max(_emptyProgress,currentIndex.toDouble()  / (stages.length).toDouble());
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

  NewStageEntity nextStage(NewStageEntity stage, List<NewStageEntity> stages) {
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

  NewStageEntity prevStage(NewStageEntity stage, List<NewStageEntity> stages) {
    return nextStage(stage, stages.reversed.toList());
  }


  bool isInProgress(NewStageEntity stage) {
    if (stage == null) {
      return false;
    }
    return isStarted(stage) && !isComplete(stage);
  }

  bool isStarted(NewStageEntity stage) {
    if (stage == null) {
      return false;
    }
    return (stage.started  != null) && stage.started.isBefore(DateTime.now());
  }

  bool isComplete(NewStageEntity stage) {
    if (stage == null) {
      return false;
    }
    return (stage.ended != null) && stage.ended.isBefore(DateTime.now());
  }

  bool canComplete(NewStageEntity stage, List<NewStageEntity> stages) {
      return isInProgress(stage);
  }

  bool canBegin(NewStageEntity stage, List<NewStageEntity> stages) {
    if (stage == null) {
      return false;
    }
    if (stage == stages.first)
    {
      return !isStarted(stage);
    }
    return isComplete(prevStage(stage, stages)) && !isStarted(stage);
  }

  bool canRevert(NewStageEntity stage, List<NewStageEntity> stages) {
    final next = nextStage(stage, stages);
    if (next == null){
      return isComplete(stage);
    }
    return isComplete(stage) && (canBegin(next, stages) || isInProgress(next));
  }

  
  
}