import 'package:farmsmart_flutter/data/model/NewStageEntity.dart';

class StageBusinessLogic {
  final List<NewStageEntity> _stages;

  StageBusinessLogic(this._stages);


  NewStageEntity currentStage() {
    for (var item in _stages) {
      if (item.started != null && item.ended == null) {
        return item;
      }
    }
    return _stages.first;
  }
  
}