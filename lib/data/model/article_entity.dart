import 'package:farmsmart_flutter/data/model/ImageEntity.dart';
import 'package:farmsmart_flutter/model/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/model/entities_const.dart';

import 'EntityCollectionInterface.dart';

class ArticleEntity {
  String id;
  String content;
  EntityCollection<ImageEntity> images;
  EntityCollection<ArticleEntity> related;
  Status status;
  String summary;
  String title;

  ArticleEntity(
      {this.id,
      this.content,
      this.status,
      this.summary,
      this.title});

  factory ArticleEntity.articleFromDocument(DocumentSnapshot articleDocument) =>
      ArticleEntity(
          id: articleDocument.data[ID],
          content: articleDocument.data[CONTENT],
          status: statusValues.map[articleDocument.data[STATUS]],
          summary: articleDocument.data[SUMMARY],
          title: articleDocument.data[TITLE]);
}
