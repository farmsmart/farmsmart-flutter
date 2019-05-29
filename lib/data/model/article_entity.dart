import 'package:farmsmart_flutter/model/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/data/model/entities_const.dart';

class ArticleEntity {
  String content;
  String imagePathReference;
  String imageUrl;
  //String relatedArticles; //TODO [FARM-95]
  Status status;
  String summary;
  String title;

  ArticleEntity({
      this.content,
      this.imagePathReference,
      this.imageUrl,
      this.status,
      this.summary,
      this.title
  });

  factory ArticleEntity.articleFromDocument(DocumentSnapshot articleDocument) => ArticleEntity(
    content: articleDocument.data[CONTENT],
    imagePathReference: articleDocument.data[IMAGE].first.path,
    imageUrl: Strings.emptyString,
    //relatedArticles: articleDocument.data[""], //TODO [FARM-95]
    status: statusValues.map[articleDocument.data[STATUS]],
    summary: articleDocument.data[SUMMARY],
    title: articleDocument.data[TITLE]
  );

  void setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
  }
}
