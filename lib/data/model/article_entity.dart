import 'package:farmsmart_flutter/data/model/related_articles.dart';
import 'package:farmsmart_flutter/model/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/data/model/entities_const.dart';

class ArticleEntity implements IsRelatedArticlesEntity {
  String content;
  String imagePathReference;
  Future<String> imageUrl;
  List<ArticleEntity> relatedArticles;
  List<String> relatedArticlesPathReference;
  Status status;
  String summary;
  String title;

  ArticleEntity(
      {this.content,
      this.imagePathReference,
      this.imageUrl,
      this.relatedArticles,
      this.relatedArticlesPathReference,
      this.status,
      this.summary,
      this.title});

  factory ArticleEntity.articleFromDocument(DocumentSnapshot articleDocument) => ArticleEntity(
          content: articleDocument.data[CONTENT],
          imagePathReference: articleDocument.data[IMAGE].first.path,
          imageUrl: Future.value(Strings.emptyString),
          relatedArticles: List(),
          relatedArticlesPathReference:
              extractRelatedArticlesPaths(articleDocument),
          status: statusValues.map[articleDocument.data[STATUS]],
          summary: articleDocument.data[SUMMARY],
          title: articleDocument.data[TITLE]);

  void setImageUrl(Future<String> imageUrl) {
    this.imageUrl = imageUrl;
  }

  void addRelatedArticle(ArticleEntity relatedArticle) {
    this.relatedArticles.add(relatedArticle);
  }

  @override
  List<ArticleEntity> getRelatedArticles() {
    return this.relatedArticles;
  }
}

List<String> extractRelatedArticlesPaths(DocumentSnapshot document) {
  if (document.data[RELATED_ARTICLES] != null) {
    return List<String>.from(
        document.data[RELATED_ARTICLES].map((stage) => stage[ARTICLE].path));
  }
  return null;
}
