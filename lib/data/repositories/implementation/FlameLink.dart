import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FlameLinkSchemaType {
  static String single = "single";
}

class FlameLinkFileType {
   static String images = "images";
}

class FlameLinkFileFields {
  static String type = "type";
  static String contentType = "contentType";
  static String name = "file";
}

class FlameLinkDocumentFields {
  static String schema = '_fl_meta_.schema';
  static String type = "_fl_meta_.schemaType";
  static String env = '_fl_meta_.env';
  static String locale = '_fl_meta_.locale';
}

enum Environment { development, production }
final _environmentValues = {
  Environment.development: "development",
  Environment.production: "production"
};

class FlameLink {
  static const defaultLocale = "en-US";
  static const _contentCollectionName = 'fl_content';
  static const _fileCollectionName = 'fl_files';
  static const _storageBasePath = "/flamelink";
  static const _imageBasePath = "media";
  final Firestore _store;
  final String _environment;
  final String _locale;

  FlameLink({Firestore store, String locale = FlameLink.defaultLocale,Environment environment = Environment.development})
      : this._store = store,
        this._locale = locale,
        this._environment = _environmentValues[environment];

  CollectionReference content() {
    return _store.collection(_contentCollectionName);
  }

  CollectionReference files() {
    return _store.collection(_fileCollectionName);
  }

  StorageReference storage({String path}) {
    final flamelinkPath =
        _storageBasePath + '/' + path;
    final storageReference =
        FirebaseStorage.instance.ref().child(flamelinkPath);
    return storageReference;
  }

  StorageReference images({String path}) {
    return storage(path: _imageBasePath + '/' + path);
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

  Query fileQuery({String type = ""}) {
    Query query = files().where(FlameLinkFileFields.type, isEqualTo: type);
    return query;
  }

  Query documentQuery({String schema = ""}) {
    Query query = documentsQuery(schema: schema, limit: 1).where(FlameLinkDocumentFields.type,
            isEqualTo: FlameLinkSchemaType.single);
    return query;
  }

  Query documentsQuery({String schema = "", int limit = 0}) {
    var query = content()
        .where(FlameLinkDocumentFields.locale, isEqualTo: _locale)
        .where(FlameLinkDocumentFields.env, isEqualTo: _environment)
        .where(FlameLinkDocumentFields.schema, isEqualTo: schema);
    if (limit > 0) {
      query = query.limit(limit);
    }
    return query;
  }
}

class FlamelinkDocumentCollection {
  final FlameLink _cms;
  final Query _query;
  final List<String> _paths;

  FlamelinkDocumentCollection({FlameLink cms, Query query})
      : _cms = cms,
        _query = query,
        _paths = [];

  FlamelinkDocumentCollection.list({FlameLink cms, List<String> paths})
      : _cms = cms,
        _paths = paths,
        _query = null;

  Future<List<DocumentSnapshot>> getDocuments({int limit = 0}) {
    if (_paths.isNotEmpty) {
      return _cms.get(_paths).then((snapshots) {
        return snapshots.toList();
      });
    } else if (_query != null) {
      return _query.getDocuments().then((snapshot) {
        return snapshot.documents.toList();
      });
    }
    return Future.value([]);
  }

  FlameLink get cms {
    return _cms;
  }
}
