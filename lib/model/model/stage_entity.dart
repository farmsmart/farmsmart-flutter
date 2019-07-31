// Maybe we can separate ui and data model with this class.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/model/entities_const.dart';

import 'article_entity.dart';
import 'enums.dart';

class StageEntity {
  String name;
  String crop;
  Status status;
  String content;
  List<ArticleEntity> stageRelatedArticles; // TODO proper design on FARM-95
  List<String> stageRelatedArticlesPathReference;

  StageEntity({
    this.name,
    this.crop,
    this.status,
    this.content,
    this.stageRelatedArticles,
    this.stageRelatedArticlesPathReference
  });

  factory StageEntity.stageFromDocument(DocumentSnapshot stageDocument) =>
      StageEntity(
        name: stageDocument.data[STAGE_NAME],
        crop: stageDocument.data[CROP],
        status: statusValues.map[stageDocument.data[STATUS]],
        content: stageDocument.data[CONTENT],
        stageRelatedArticles: List(),
        stageRelatedArticlesPathReference: null
      );

  void addStageRelatedArticle(ArticleEntity relatedArticle) {
    this.stageRelatedArticles.add(relatedArticle);
  }
}


