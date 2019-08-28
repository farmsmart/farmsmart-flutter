import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/model/entities/article_entity.dart';
import 'package:farmsmart_flutter/model/entities/enums.dart';
import 'package:farmsmart_flutter/model/repositories/article/implementation/FlameLinkMetaTransformer.dart';
import '../../../firebase_const.dart';
import '../../FlameLink.dart';
import '../ArticleRepositoryInterface.dart';
import 'transformers/FirebaseArticleTransformer.dart';

class _Fields  {
  static final articleCollection = "articles";
  static final articleEntry = "article";
  static final chatGroupCollection = "chatGroups";
  static final chatGroupEntry = "chatGroup";
  static final articleSchema = "article";
  static final articleDirectoryName = "articleDirectory";
  static final chatGroupDirectoryName = "chatGroupDirectory";
}


ArticleEntity _transform(FlameLink cms, DocumentSnapshot snapshot) {
  final transformer = FlamelinkArticleTransformer(cms: cms, metaTransformer: FlamelinkMetaTransformer());
  return transformer.transform(from: snapshot);
}

class ArticleEntityCollectionFlamelink implements EntityCollection<ArticleEntity> {
  final FlamelinkDocumentCollection _collection;
  final bool _onlyPublished;

  ArticleEntityCollectionFlamelink({FlamelinkDocumentCollection collection, bool onlyPublished = true})
      : _collection = collection, _onlyPublished = onlyPublished;

  @override
  Future<List<ArticleEntity>> getEntities({int limit = 0}) {
    return _collection.getDocuments().then((documents) { 
      var articles =  documents.map((document) => _transform(_collection.cms, document)).toList(); 
      if(_onlyPublished) {
          articles.removeWhere((article) { return article.status != Status.PUBLISHED;});
      }
      return articles;
      });
  }
}

class ArticlesRepositoryFlameLink implements ArticleRepositoryInterface {
  final FlameLink _cms;

  ArticlesRepositoryFlameLink(FlameLink cms) : _cms = cms;

  @override
  Future<ArticleEntity> getArticle(uri) {
    if (uri.isEmpty) {
      return null;
    }
    final baseCollection = _cms.content();
    return baseCollection
        .document(uri)
        .get()
        .then((snapshot) => _transform(_cms, snapshot));
  }

  @override
  Stream<ArticleEntity> observeArticle(uri) {
    if (uri.isEmpty) {
      return null;
    }
    final baseCollection = _cms.content();
    final _typeTransform =
        StreamTransformer<DocumentSnapshot, ArticleEntity>.fromHandlers(
            handleData: (snapshot, sink) {
      sink.add(_transform(_cms, snapshot));
    });
    return baseCollection.document(uri).snapshots().transform(_typeTransform);
  }

  @override
  Future<List<ArticleEntity>> getArticles(EntityCollection<ArticleEntity> collection) {
    return collection.getEntities();
  }

  @override
  Future<List<ArticleEntity>> get(
      {ArticleCollectionGroup group = ArticleCollectionGroup.all,
      int limit = 0}) {
    switch (group) {
      case ArticleCollectionGroup.discovery:
        return getDirectory(directoryName: _Fields.articleDirectoryName, collectionName: _Fields.articleCollection, entryName: _Fields.articleEntry );
        break;
      case ArticleCollectionGroup.chatGroups:
        return getDirectory(directoryName: _Fields.chatGroupDirectoryName, collectionName: _Fields.chatGroupCollection, entryName: _Fields.chatGroupEntry);
        break;
      default:
        final publishedDocuments = _cms
            .documentsQuery(schema: _Fields.articleSchema, limit: limit)
            .where(PUBLICATION_STATUS, isEqualTo: DataStatus.PUBLISHED);
        final collection = FlamelinkDocumentCollection(cms: _cms, query: publishedDocuments);
        return ArticleEntityCollectionFlamelink(collection: collection)
            .getEntities();
    }
  }

  Future<List<ArticleEntity>> getDirectory({String directoryName, String collectionName, String entryName}) {
    return _cms.getSingle(schema: directoryName).then((snapshot) {
      final refs = snapshot.data[collectionName]
          .map((article) => article[entryName].path.toString())
          .toList();
      final paths = List<String>.from(refs);
      final collection = FlamelinkDocumentCollection.list(cms: _cms, paths: paths);
      return ArticleEntityCollectionFlamelink(collection: collection).getEntities();
    });
  }
}
