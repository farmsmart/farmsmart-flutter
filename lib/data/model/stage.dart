// Maybe we can separate ui and data model with this class.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/enums.dart';

class Stage {
  String name;
  String crop;
  Status status;
  String content;
  String relatedArticles; // TODO proper design on FARM-95

  Stage({
    this.name,
    this.crop,
    this.status,
    this.content,
    this.relatedArticles
  });

  factory Stage.stageFromDocument(DocumentSnapshot stageDocument) =>
      Stage(
        name: stageDocument.data["stageName"],
        crop: stageDocument.data["crop"],
        status: statusValues.map[stageDocument.data["status"]],
        content: stageDocument.data["content"],
        relatedArticles: stageDocument.data["relatedArticles"].toString(),
      );
}