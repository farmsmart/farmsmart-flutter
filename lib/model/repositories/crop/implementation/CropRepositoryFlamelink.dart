import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';

import 'package:farmsmart_flutter/model/entities/crop_entity.dart';
import 'package:farmsmart_flutter/model/entities/enums.dart';
import 'package:farmsmart_flutter/model/repositories/article/implementation/FlameLinkMetaTransformer.dart';

import '../../../firebase_const.dart';
import '../../FlameLink.dart';
import '../CropRepositoryInterface.dart';
import 'transformers/FirebaseCropTransformer.dart';

class _Fields {
  static final cropSchema = "crop";
}

CropEntity _transform(
  FlameLink cms,
  DocumentSnapshot snapshot,
) {
  final transformer = FlamelinkCropTransformer(
    cms: cms,
    metaTransformer: FlamelinkMetaTransformer(),
  );
  return transformer.transform(from: snapshot);
}

class CropEntityCollectionFlamelink implements EntityCollection<CropEntity> {
  final FlamelinkDocumentCollection _collection;
  final bool _onlyPublished;

  CropEntityCollectionFlamelink({
    FlamelinkDocumentCollection collection,
    bool onlyPublished = true,
  })  : _collection = collection,
        _onlyPublished = onlyPublished;

  @override
  Future<List<CropEntity>> getEntities({int limit = 0}) {
    return _collection.getDocuments().then((documents) {
      var articles = documents
          .map((document) => _transform(
                _collection.cms,
                document,
              ))
          .toList();
      if (_onlyPublished) {
        articles.removeWhere((article) {
          return article.status != Status.PUBLISHED;
        });
      }
      return articles;
    });
  }
}

class CropRepositoryFlamelink implements CropRepositoryInterface {
  final FlameLink _cms;

  CropRepositoryFlamelink(this._cms);

  @override
  Future<List<CropEntity>> get({
    CropCollectionGroup group = CropCollectionGroup.all,
    int limit = 0,
  }) {
    switch (group) {
      default:
        final publishedDocuments = _cms
            .documentsQuery(
              schema: _Fields.cropSchema,
              limit: limit,
            )
            .where(
              PUBLICATION_STATUS,
              isEqualTo: DataStatus.PUBLISHED,
            );
        final collection = FlamelinkDocumentCollection(
          cms: _cms,
          query: publishedDocuments,
        );
        return CropEntityCollectionFlamelink(collection: collection)
            .getEntities();
    }
  }

  @override
  Future<List<CropEntity>> getCollection(
      EntityCollection<CropEntity> collection) {
    return collection.getEntities();
  }

  @override
  Future<CropEntity> getSingle(String uri) {
    if (uri.isEmpty) {
      return null;
    }
    final baseCollection = _cms.content();
    return baseCollection.document(uri).get().then((snapshot) => _transform(
          _cms,
          snapshot,
        ));
  }

  @override
  Stream<CropEntity> observeSingle(String uri) {
    if (uri.isEmpty) {
      return null;
    }
    final baseCollection = _cms.content();
    final _typeTransform =
        StreamTransformer<DocumentSnapshot, CropEntity>.fromHandlers(
            handleData: (snapshot, sink) {
      sink.add(_transform(
        _cms,
        snapshot,
      ));
    });
    return baseCollection.document(uri).snapshots().transform(_typeTransform);
  }
}
