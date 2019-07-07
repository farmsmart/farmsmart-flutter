import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/bloc/Transformer.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/entities_const.dart';
import 'package:farmsmart_flutter/data/repositories/image/implementation/ImageRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/model/enums.dart';

import '../../../FlameLink.dart';
import '../../../FlamelinkMeta.dart';
import '../ArticlesRepositoryFlamelink.dart';
import '../FlameLinkMetaTransformer.dart';

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
    final id = castOrNull<String>(from.data[ID]);
    final content = castOrNull<String>(from.data[CONTENT]);
    final status = castOrNull<String>(from.data[STATUS]);
    final summary = castOrNull<String>(from.data[SUMMARY]);
    final title = castOrNull<String>(from.data[TITLE]);
    final entity = ArticleEntity(
        id: id,
        content: content,
        status: statusValues.map[status],
        summary: summary,
        title: title,
        published: meta.createdDate);
    var relatedRefs = [];
    var imageRefs = [];
    if (from.data[RELATED_ARTICLES] != null) {
      relatedRefs = List<String>.from(from.data[RELATED_ARTICLES]
          .map((article) => article[ARTICLE].path)).toList();
    }
    if (from.data[IMAGE] != null) {
      imageRefs = List<String>.from(from.data[IMAGE].map((image) => image.path))
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
