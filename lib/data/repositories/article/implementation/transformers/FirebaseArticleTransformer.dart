import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/bloc/Transformer.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/repositories/image/implementation/ImageRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/model/enums.dart';

import '../../../FlameLink.dart';
import '../../../FlamelinkMeta.dart';
import '../ArticlesRepositoryFlamelink.dart';
import '../FlameLinkMetaTransformer.dart';

class _Fields {
  static String id = "id";
  static String content = "content";
  static String status = "status";
  static String summary = "summary";
  static String title = "title";
  static String name = "name";
  static String related = "relatedArticles";
  static String article = "article";
  static String image = "image";
}

class FlamelinkArticleTransformer
    implements ObjectTransformer<DocumentSnapshot, ArticleEntity> {
  final ObjectTransformer<DocumentSnapshot, FlamelinkMeta> _metaTransformer;
  final FlameLink _cms;

  FlamelinkArticleTransformer(
      {FlameLink cms,
      ObjectTransformer<DocumentSnapshot, FlamelinkMeta> metaTransformer =
          const FlamelinkMetaTransformer()})
      : this._cms = cms,
        this._metaTransformer = metaTransformer;

  @override
  ArticleEntity transform({DocumentSnapshot from}) {
    final meta = _metaTransformer.transform(from: from);
    final id = castOrNull<String>(from.data[_Fields.id]);
    final content = castOrNull<String>(from.data[_Fields.content]);
    final status = castOrNull<String>(from.data[_Fields.status]);
    final summary = castOrNull<String>(from.data[_Fields.summary]);
    final title = castOrNull<String>(from.data[_Fields.title]) ?? castOrNull<String>(from.data[_Fields.name]) ;
    final published =
        (meta.createdDate != null) ? meta.createdDate.toDate() : null;
    final entity = ArticleEntity(
        id: id,
        content: content,
        status: statusValues.map[status],
        summary: summary,
        title: title,
        published: published);
    var relatedRefs = [];
    var imageRefs = [];
    if (from.data[_Fields.related] != null) {
      relatedRefs = List<String>.from(from.data[_Fields.related]
          .map((article) => article[_Fields.article].path)).toList();
    }
    if (from.data[_Fields.image] != null) {
      imageRefs =
          List<String>.from(from.data[_Fields.image].map((image) => image.path))
              .toList();
    }
    final relatedPaths = List<String>.from(relatedRefs);
    final imagePaths = List<String>.from(imageRefs);

    final articleCollection =
        FlamelinkDocumentCollection.list(cms: _cms, paths: relatedPaths);
    final imageCollection =
        FlamelinkDocumentCollection.list(cms: _cms, paths: imagePaths);
    entity.related =
        ArticleEntityCollectionFlamelink(collection: articleCollection);
    entity.images = ImageEntityCollectionFlamelink(collection: imageCollection);
    return entity;
  }
}
