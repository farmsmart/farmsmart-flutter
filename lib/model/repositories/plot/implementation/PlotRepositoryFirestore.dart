import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/model/entities/PlotEntity.dart';
import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/entities/StageEntity.dart';
import 'package:farmsmart_flutter/model/entities/crop_entity.dart';
import 'package:farmsmart_flutter/model/repositories/article/implementation/FlameLinkMetaTransformer.dart';
import 'package:farmsmart_flutter/model/repositories/crop/implementation/transformers/FirebaseCropStageTransformer.dart';
import 'package:farmsmart_flutter/model/repositories/crop/implementation/transformers/FirebaseCropTransformer.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';

import '../../FlameLink.dart';
import '../PlotRepositoryInterface.dart';
import 'PlotFirestoreTransformers.dart';

class _Fields {
  static const title = "title";
  static const startDate = "startDate";
  static const endDate = "endDate";
  static const plotCollectionPath = "/plots";
}

class PlotRepositoryFireStore implements PlotRepositoryInterface {
  final Firestore firestore;
  final FlameLink flamelink;
  final ProfileRepositoryInterface profileRepository;
  final _controller = StreamController<List<PlotEntity>>.broadcast();
  PlotRepositoryFireStore(
    Firestore firestore,
    FlameLink flameLink,
    ProfileRepositoryInterface profileRepository,
  )   : this.firestore = firestore,
        this.flamelink = flameLink,
        this.profileRepository = profileRepository {
    profileRepository.observeCurrent().listen((profile) {
      firestore
          .collection(_plotListPathFor(profile))
          .snapshots()
          .listen((snapshot) {
        Future.wait(snapshot.documents.map((document) {
          return _transformFromFirebase(document);
        })).then((plots) {
          _controller.sink.add(plots.toList());
        });
      });
    });
  }

  @override
  Future<PlotEntity> addPlot({
    Map<String, String> plotInfo,
    CropEntity crop,
  }) {
    return crop.stageArticles.getEntities().then((articles) {
      final stages = articles.map((article) {
        return StageEntity(
          id: article.uri,
          article: article,
        );
      }).toList();
      final plot =
          PlotEntity(title: crop.name, crop: crop, score: 0.0, stages: stages);
      return _plotListPath().then((path) {
        return firestore
            .collection(path)
            .add(_transformToFirebase(plot))
            .then((documentRef) {
          return documentRef.get().then((document) {
            return _transformFromFirebase(document);
          });
        });
      });
    });
  }

  @override
  Future<PlotEntity> beginStage(
    PlotEntity forPlot,
    StageEntity stage,
  ) {
    return Future.value(forPlot);
    //final data = {_Fields.startDate: Timestamp.fromDate(DateTime.now())};
    //return firestore.document(stage.id).setData(data, merge: true);
  }

  @override
  Future<PlotEntity> completeStage(
    PlotEntity forPlot,
    StageEntity stage,
  ) {
    return Future.value(forPlot);
    //final data = {_Fields.endDate: Timestamp.fromDate(DateTime.now())};
    //return firestore.document(stage.id).setData(data, merge: true);
  }

  @override
  Future<List<PlotEntity>> getCollection(
      EntityCollection<PlotEntity> collection) {
    return collection.getEntities();
  }

  @override
  Future<List<PlotEntity>> getFarm() {
    return _plotListPath().then((path) {
      return firestore.collection(path).getDocuments().then((snapshot) {
        return Future.wait(snapshot.documents.map((document) {
          return _transformFromFirebase(document);
        })).then((plots) {
          _controller.sink.add(plots);
          return plots;
        });
      });
    });
  }

  @override
  Future<PlotEntity> getSingle(String uri) {
    return firestore.document(uri).get().then((document) {
      return _transformFromFirebase(document);
    });
  }

  @override
  Stream<List<PlotEntity>> observeFarm() {
    return _controller.stream;
  }

  @override
  Stream<PlotEntity> observeSingle(String uri) {
    return firestore.document(uri).snapshots().transform(
        StreamTransformer<DocumentSnapshot, PlotEntity>.fromHandlers(
            handleData: (document, sink) {
      if (document.data == null) return;
      _transformFromFirebase(document).then((plot) {
        sink.add(plot);
      });
    }));
  }

  @override
  Future<bool> remove(PlotEntity plot) {
    return firestore.document(plot.uri).delete().then((_) {
      return true;
    }, onError: (error) {
      return false;
    });
  }

  @override
  Future<PlotEntity> rename(
    PlotEntity plot,
    String name,
  ) {
    final data = {_Fields.title: name};
    final documentRef = firestore.document(plot.uri);
    return documentRef.setData(data, merge: true).then((_) {
      return documentRef.get().then((document) {
        return _transformFromFirebase(document);
      });
    });
  }

  @override
  Future<PlotEntity> revertStage(
    PlotEntity forPlot,
    StageEntity stage,
  ) {
    return Future.value(forPlot);
    //final data = {_Fields.endDate: null};
    //return firestore.document(stage.id).setData(data, merge: true);
  }

  String _plotListPathFor(ProfileEntity profile) {
    return profile.uri + _Fields.plotCollectionPath;
  }

  Future<String> _plotListPath() {
    return profileRepository.getCurrent().then((profile) {
      return _plotListPathFor(profile);
    });
  }

  Map<String, dynamic> _transformToFirebase(PlotEntity plot) {
    final transformer = PlotEntityToDocumentTransformer();
    return transformer.transform(from: plot);
  }

  Future<PlotEntity> _transformFromFirebase(DocumentSnapshot plotDocument) {
    if (plotDocument.data != null) {
      final transformer = DocumentToPlotEntityTransformer();
      final cropURI = transformer.cropURI(from: plotDocument);
      final cropTransformer = FlamelinkCropTransformer(
        cms: flamelink,
        metaTransformer: FlamelinkMetaTransformer(),
      );
      return firestore.document(cropURI).get().then((cropDocument) {
        final crop = cropTransformer.transform(from: cropDocument);
        return _transformStagesFromFirebase(plotDocument).then((stages) {
          return transformer.transform(
            from: plotDocument,
            crop: crop,
            stages: stages,
          );
        });
      });
    }
    return Future.value(null);
  }

  Future<List<StageEntity>> _transformStagesFromFirebase(
      DocumentSnapshot plotDocument) {
    final stages =
        castListOrNull<Map>(plotDocument.data["stages"]);
    return Future.wait(stages.map((stage) {
      final articlePath = castOrNull<String>(stage["articlePath"]);
      final started = castOrNull<Timestamp>(stage["started"]);
      final ended = castOrNull<Timestamp>(stage["ended"]);
      final id = castOrNull<String>(stage["id"]);
      final stageArticleTransformer = FlamelinkCropArticleTransformer(
        cms: flamelink,
        metaTransformer: FlamelinkMetaTransformer(),
      );
      return firestore.document(articlePath).get().then((artcileDocument) {
        final stageArticle =
            stageArticleTransformer.transform(from: artcileDocument);
        return StageEntity(
          id: id,
          article: stageArticle,
          started: started?.toDate(),
          ended: ended?.toDate(),
        );
      });
    }));
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
