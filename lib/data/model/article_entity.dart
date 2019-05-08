import 'package:farmsmart_flutter/model/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/utils/strings.dart';

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
    content: articleDocument.data[Strings.documentFieldContent],
    imagePathReference: articleDocument.data[Strings.documentFieldImage].first.path,
    imageUrl: Strings.emptyString,
    //relatedArticles: articleDocument.data[""], //TODO [FARM-95]
    status: statusValues.map[articleDocument.data[Strings.documentFieldStatus]],
    summary: articleDocument.data[Strings.documentFieldSummary],
    title: articleDocument.data[Strings.documentFileTitle]
  );

  void setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
  }
}
