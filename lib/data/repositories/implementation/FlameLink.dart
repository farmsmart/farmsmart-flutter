import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<List<DocumentSnapshot>> get(List<String> paths) async {
    var fetchRequests;
    final baseCollection = content();
    for (var path in paths) {
        fetchRequests.add(baseCollection.document(path).get());
    }
    return Future.wait(fetchRequests);
  }

  Query documentsQuery({String schema = "", int limit = 0}) {
    var query = content()
        .where(FlameLinkDocumentFields.type, isEqualTo: FlameLinkSchemaType.single);
    if (schema.isNotEmpty) {
      query = query.where(FlameLinkDocumentFields.schema, isEqualTo: schema);
    }
    if (limit > 0) {
      query = query.limit(limit);
    }
    return query; 
  }
}
