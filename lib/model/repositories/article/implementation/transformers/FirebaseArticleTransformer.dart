import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/entities/article_entity.dart';
import 'package:farmsmart_flutter/model/entities/enums.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/ImageRepositoryFlamelink.dart';

import '../../../FlameLink.dart';
import '../../../FlamelinkMeta.dart';
import '../ArticlesRepositoryFlamelink.dart';

class _Fields {
  static String content = "content";
  static String status = "status";
  static String summary = "summary";
  static String title = "title";
  static String name = "name";
  static String relatedArticles = "relatedArticles";
  static String article = "article";
  static String relatedChatGroups = "relatedChatGroups";
  static String chatGroup = "chatGroup";
  static String image = "image";
  static String externalLink = "contentLink";
}

class FlamelinkArticleTransformer
    extends ObjectTransformer<DocumentSnapshot, ArticleEntity> {
  final ObjectTransformer<DocumentSnapshot, FlamelinkMeta> _metaTransformer;
  final FlameLink _cms;

  FlamelinkArticleTransformer(
      {FlameLink cms,
      ObjectTransformer<DocumentSnapshot, FlamelinkMeta> metaTransformer})
      : this._cms = cms,
        this._metaTransformer = metaTransformer;

  @override
  ArticleEntity transform({DocumentSnapshot from}) {
    final meta = _metaTransformer.transform(from: from);
    final uri = from.reference.path;
    final content = castOrNull<String>(from.data[_Fields.content]);
    final status = castOrNull<String>(from.data[_Fields.status]);
    final summary = castOrNull<String>(from.data[_Fields.summary]);
    final title = castOrNull<String>(from.data[_Fields.title]) ??
        castOrNull<String>(from.data[_Fields.name]);
    final externalLink = castOrNull<String>(from.data[_Fields.externalLink]);
    final published =
        (meta.createdDate != null) ? meta.createdDate.toDate() : null;
    final entity = ArticleEntity(
        uri: uri,
        content: content,
        status: statusValues.map[status],
        summary: summary,
        title: title,
        published: published,
        externalLink: externalLink);
    var relatedRefs = _relatedRefs(from);
    var imageRefs = [];
    if (from.data[_Fields.image] != null) {
      imageRefs =
          List<String>.from(from.data[_Fields.image].map((image) => image.path))
              .toList();
    }
    final relatedPaths = List<String>.from(relatedRefs);
    final imagePaths = imageRefs.isNotEmpty ? List<String>.from(imageRefs) : null;

    final articleCollection =
        FlamelinkDocumentCollection.list(cms: _cms, paths: relatedPaths);
    final imageCollection = (imagePaths != null) ? FlamelinkDocumentCollection.list(cms: _cms, paths: imagePaths) : null;
    entity.related =
        ArticleEntityCollectionFlamelink(collection: articleCollection);
    entity.images = ImageEntityCollectionFlamelink(collection: imageCollection);
    return entity;
  }

  List<String> _relatedRefs(DocumentSnapshot from) {
    final related = _related(
          from,
          _Fields.relatedArticles,
          _Fields.article,
        ) ??
        _related(
          from,
          _Fields.relatedChatGroups,
          _Fields.chatGroup,
        );
    return related ?? [];
  }

  List<String> _related(
      DocumentSnapshot from, String collectionName, String itemName) {
    if (from.data[collectionName] != null) {
      return List<String>.from(from.data[collectionName].map((item) {
        final documentRef = castOrNull<DocumentReference>(item[itemName]);
        if (documentRef != null) {
          return documentRef.path;
        }
        return null;
      })).where((item) {
        return (item != null);
      }).toList();
    }
    return null;
  }
}
