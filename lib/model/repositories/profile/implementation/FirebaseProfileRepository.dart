import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'DocumentToProfileEntityTransformer.dart';
import 'ProfileEntityToDocumentTransformer.dart';

class _Fields {
  static const collectionName = "fs_users";
  static const ownerID = "owner";
  static const profiles = "profiles";
  static const currentProfile = "currentProfile";
  static const separator = "/";
}

class FirebaseProfileRepository implements ProfileRepositoryInterface {
  final Firestore _firestore;
  final FirebaseAuth _auth;
  final _transformToFirebase = ProfileEntityToDocumentTransformer();
  final _transformFromFirebase = DocumentToProfileEntityTransformer();
  final _currentProfileController = StreamController<ProfileEntity>.broadcast();
  final _profilesListController =
      StreamController<List<ProfileEntity>>.broadcast();
  Future<FirebaseUser> _user;
  FirebaseProfileRepository(Firestore firestore, FirebaseAuth auth)
      : this._firestore = firestore,
        this._auth = auth {
    init();
  }

  init() {
    _user = _auth.currentUser().then((user) {
      return user;
    });
    _auth.onAuthStateChanged.listen((user) {
      _user = Future.value(user);
    });
  }

  @override
  Future<ProfileEntity> add(ProfileEntity profile) {
    return _user.then((user) {
      final Map<String, dynamic> data =
          _transformToFirebase.transform(from: profile);
      return _profilesCollection(user).add(data).then((result) {
        return result.get().then((document) {
          return _transformFromFirebase.transform(from: document);
        });
      });
    });
  }

  @override
  Future<List<ProfileEntity>> getAll() {
    return _user.then((user) {
      return _profilesCollection(user).getDocuments().then((snapshot) {
        final profileList = snapshot.documents.map((document) {
          return _transformFromFirebase.transform(from: document);
        }).toList();
        _profilesListController.sink.add(profileList);
        return profileList;
      }, onError: (error) {
        List<ProfileEntity> emptyList = [];
        _profilesListController.sink.add(emptyList);
        return emptyList;
      });
    });
  }

  @override
  Future<List<ProfileEntity>> getCollection(
      EntityCollection<ProfileEntity> collection) {
    return collection.getEntities();
  }

  @override
  Future<ProfileEntity> getCurrent() {
    return _user.then((user) {
      if (user != null) {
        return _firestore.document(_userPath(user)).get().then((document) {
          if (document.data != null) {
            final currentDocumentID = document.data[_Fields.currentProfile];
            if (currentDocumentID != null) {
              final path = _currentProfilePath(user, currentDocumentID);
              return _firestore.document(path).get().then((document) {
                final profile =
                    _transformFromFirebase.transform(from: document);
                _currentProfileController.sink.add(profile);
                return profile;
              });
            }
          }
          return null;
        });
      }
    });
  }

  @override
  Future<ProfileEntity> getSingle(String uri) {
    // TODO: implement getSingle
    return null;
  }

  @override
  Stream<ProfileEntity> observe(String uri) {
    // TODO: implement observe
    return null;
  }

  @override
  Stream<List<ProfileEntity>> observeAll() {
    return _profilesListController.stream;
  }

  @override
  Stream<ProfileEntity> observeCurrent() {
    return _currentProfileController.stream;
  }

  @override
  Future<bool> remove(ProfileEntity profile) {
    return _user.then((user) {
      return _firestore.document(_userPath(user)).get().then((document) {
        if (document.data != null) {
          final currentDocumentID = document.data[_Fields.currentProfile];
          final path = _currentProfilePath(user, currentDocumentID);
          return _firestore.document(path).delete().then((response) {
            return true;
          }, onError: (error) {
            return false;
          });
        }
        return false;
      });
    });
  }

  @override
  Future<bool> switchTo(ProfileEntity profile) {
    return _user.then((user) {
      final id = (profile != null) ? profile.id : null;
      final data = {_Fields.currentProfile: id};
      return _firestore.document(_userPath(user)).setData(data).then((result) {
        _currentProfileController.sink.add(profile);
        return true;
      });
    }, onError: (error) {
      return false;
    });
  }

  String _currentProfilePath(FirebaseUser user, String profileID) {
    return _userPath(user) +
        _Fields.separator +
        _Fields.profiles +
        _Fields.separator +
        profileID;
  }

  String _userPath(FirebaseUser user) {
    return _Fields.collectionName + _Fields.separator + user.uid;
  }

  CollectionReference _profilesCollection(FirebaseUser user) {
    final path = _userPath(user) + _Fields.separator + _Fields.profiles;
    return _firestore.collection(path);
  }

  void deinit() {
    _currentProfileController.sink.close();
    _currentProfileController.close();
    _profilesListController.sink.close();
    _profilesListController.close();
  }
}
