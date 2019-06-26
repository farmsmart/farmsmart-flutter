import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';

class FlameLinkSchemaType {
  static String single = "single";
}

class FlameLinkDocumentFields {
  static String schema = '_fl_meta_.schema';
  static String type = "_fl_meta_.schemaType";
  static String env = '_fl_meta_.env';
  static String locale = '_fl_meta_.locale';
}

class FlameLink {
  static const _contentCollectionName = 'fl_content';
  final Firestore _store;

  FlameLink(Firestore store) : this._store = store;

  CollectionReference content() {
    return _store.collection(_contentCollectionName);
  }

  Future<DocumentSnapshot> getSingle({String schema}) {
    return documentQuery(schema: schema).getDocuments().then((snapshot) { 
      return snapshot.documents.singleWhere((_) => true, orElse: null);
    });
  }

  Future<List<DocumentSnapshot>> get(List<String> paths) {
    final fetchRequests = paths.map((path) => _store.document(path).get());
    return Future.wait(fetchRequests);
  }

  Query documentQuery({String schema = ""}) {
     Query query = content().where(FlameLinkDocumentFields.schema, isEqualTo: schema)
      .where(FlameLinkDocumentFields.type, isEqualTo: FlameLinkSchemaType.single).limit(1);
      return query;
  }

  Query documentsQuery({String schema = "", int limit = 0}) {
    var query = content().where(FlameLinkDocumentFields.schema, isEqualTo: schema);
    if (limit > 0) {
      query = query.limit(limit);
    }
    return query; 
  }
}
