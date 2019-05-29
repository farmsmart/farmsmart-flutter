// Maybe we can separate ui and data model with this class.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/enums.dart';
import 'package:farmsmart_flutter/data/model/entities_const.dart';

class StageEntity {
  String name;
  String crop;
  Status status;
  String content;
  String relatedArticles; // TODO proper design on FARM-95

  StageEntity({
    this.name,
    this.crop,
    this.status,
    this.content,
    this.relatedArticles
  });

  factory StageEntity.stageFromDocument(DocumentSnapshot stageDocument) =>
      StageEntity(
        name: stageDocument.data[STAGE_NAME],
        crop: stageDocument.data[CROP],
        status: statusValues.map[stageDocument.data[STATUS]],
        content: stageDocument.data[CONTENT],
        relatedArticles: stageDocument.data[RELATED_ARTICLES].toString(),
      );
}


