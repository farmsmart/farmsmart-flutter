import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';


class _Strings {
  static const separator = "/" ;
}

typedef PathProvider = Future<String> Function();
typedef ObjectIdentifier<T> = String Function(T object);

class FireStoreList<T> {
  final Firestore firestore;
  final ObjectTransformer<T, Map<String, dynamic>> toFirestoreTransformer;
  final ObjectTransformer<DocumentSnapshot, T> fromFirestoreTransformer;
  PathProvider path;
  ObjectIdentifier<T> identifier;
  StreamController<List<T>> _listController;

  FireStoreList(
    this.firestore,
    this.toFirestoreTransformer,
    this.fromFirestoreTransformer,
    this.path, 
    this.identifier,
  );

  Future<T> add(T object) {
    return path().then((collectionPath) {
      final firestoreObject = toFirestoreTransformer.transform(from: object);
      return firestore
          .collection(collectionPath)
          .add(firestoreObject)
          .then((result) {
        return result.get().then((document) {
          return fromFirestoreTransformer.transform(from: document);
        });
      });
    });
  }

  Future<bool> remove(T object) {
     return path().then((collectionPath) {
          final documentPath = collectionPath + _Strings.separator + identifier(object);
          return firestore.document(documentPath).delete().then((response) {
            return true;
          }, onError: (error) {
            return false;
          });
    });
  }
  
  Stream<List<T>> stream() {
    if(_listController == null)
    {
      _listController =  StreamController<List<T>>.broadcast();
      path().then((collectionPath) {
        firestore.collection(collectionPath).snapshots().listen((snapshot){
          _listController.sink.add(_transformCollection(snapshot));
        });
      });
    }
    return _listController.stream;
  } 

  Future<List<T>> get() {
    return path().then((collectionPath) {
      return firestore.collection(collectionPath).getDocuments().then(
          (snapshot) {
        final newValue = _transformCollection(snapshot);
         _listController.sink.add(newValue);
        return newValue;
      }, onError: (error) {
        return List<T>();
      });
    });
  }

  List<T> _transformCollection(QuerySnapshot snapshot) {
    return snapshot.documents.map((document) {
          return fromFirestoreTransformer.transform(from: document);
        }).toList();
  }

  void dispose(){
    _listController?.sink?.close();
    _listController?.close();
  }
}
