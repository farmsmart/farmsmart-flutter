import 'package:farmsmart_flutter/model/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleEntity {
  String content;
  String imagePathReference;
  String imageUrl;
  //String relatedArticles; //TODO Ask how it works
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
    content: articleDocument.data["content"],
    imagePathReference: articleDocument.data["image"].first.path,
    imageUrl: "",
    //relatedArticles: articleDocument.data[""],
    status: statusValues.map[articleDocument.data["status"]],
    summary: articleDocument.data["summary"],
    title: articleDocument.data["title"]
  );

  void setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
  }
}
