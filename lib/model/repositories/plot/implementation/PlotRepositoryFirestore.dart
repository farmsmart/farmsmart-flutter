import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/analytics_interface.dart';
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
  static const plotCollectionPath = "/plots";
  static const orderField = "order";
}

class _AnalyticsNames {
  static const addToPlot = 'add_to_plot';
  static const removedFromPlot = 'removed_from_plot';
  static const renamedPlot = 'renamed_plot';
  static const beganStage = 'began_stage';
  static const completedStage = 'completed_stage';
  static const revertedStage = 'reverted_stage';
  static const completedCrop = 'completed_crop';
  static const cropNameParameter = 'crop_name';
  static const cropIdParameter = 'crop_id';
  static const plotTitle = 'plot_title';
  static const stageIdParameter = 'stage_id';
  static const stageTitleParameter = 'stage_title';
  static const plotScoreParameter = 'plot_score';
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
          .orderBy(
            _Fields.orderField,
            descending: true,
          )
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
    Map<String, Map<String, String>> plotInfo,
    CropEntity crop,
  }) {
    return crop.stageArticles.getEntities().then((articles) {
      final stages = articles.map((article) {
        return StageEntity(
          id: article.uri,
          article: article,
        );
      }).toList();

      final plot = PlotEntity(
        title: crop.name,
        crop: crop,
        score: 0.0,
        stages: stages,
      );
      var firestorePlot = _transformToFirebase(plot);
      firestorePlot[_Fields.orderField] = Timestamp.now();
      return _plotListPath().then((path) {
        return firestore
            .collection(path)
            .add(firestorePlot)
            .then((documentRef) {
          AnalyticsInterface.implementation().effect(_AnalyticsNames.addToPlot,
              parameters: _analyticsParameters(crop: crop));
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
    final startedStage = _stageWithDates(
      stage,
      DateTime.now(),
      stage.ended,
    );
    final updatedPlot = _replaceStage(forPlot, stage, startedStage);
    final firebasePlot = _transformToFirebase(updatedPlot);
    return firestore
        .document(forPlot.uri)
        .setData(firebasePlot, merge: true)
        .then((result) {
      AnalyticsInterface.implementation().effect(_AnalyticsNames.beganStage,
          parameters: _analyticsParameters(plot: forPlot, stage: startedStage));
      return updatedPlot;
    });
  }

  @override
  Future<PlotEntity> completeStage(
    PlotEntity forPlot,
    StageEntity stage,
  ) {
    final completedStage = _stageWithDates(
      stage,
      stage.started,
      DateTime.now(),
    );
    final updatedPlot = _replaceStage(
      forPlot,
      stage,
      completedStage,
    );
    final firebasePlot = _transformToFirebase(updatedPlot);
    return firestore
        .document(forPlot.uri)
        .setData(firebasePlot, merge: true)
        .then((result) {
      AnalyticsInterface.implementation().effect(_AnalyticsNames.completedStage,
          parameters: _analyticsParameters(plot: forPlot, crop: forPlot.crop));
      if (stage.id == forPlot.stages.last.id) {
        AnalyticsInterface.implementation().effect(
            _AnalyticsNames.completedCrop,
            parameters:
                _analyticsParameters(plot: forPlot, crop: forPlot.crop));
      }
      return updatedPlot;
    });
  }

  @override
  Future<List<PlotEntity>> getCollection(
      EntityCollection<PlotEntity> collection) {
    return collection.getEntities();
  }

  @override
  Future<List<PlotEntity>> getFarm() {
    return _plotListPath().then((path) {
      return firestore
          .collection(path)
          .orderBy(
            _Fields.orderField,
            descending: true,
          )
          .getDocuments()
          .then((snapshot) {
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
      AnalyticsInterface.implementation().effect(
          _AnalyticsNames.removedFromPlot,
          parameters: _analyticsParameters(plot: plot));
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
    final data = {PlotEntityFields.title: name};
    final documentRef = firestore.document(plot.uri);
    return documentRef
        .setData(
      data,
      merge: true,
    )
        .then((_) {
      AnalyticsInterface.implementation().effect(_AnalyticsNames.renamedPlot,
          parameters: _analyticsParameters(plot: plot));
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
    final updatedPlot = _revertStage(forPlot, stage);
    final firebasePlot = _transformToFirebase(updatedPlot);
    return firestore
        .document(forPlot.uri)
        .setData(
          firebasePlot,
          merge: true,
        )
        .then((result) {
      AnalyticsInterface.implementation().effect(_AnalyticsNames.revertedStage,
          parameters: _analyticsParameters(plot: forPlot, stage: stage));
      return updatedPlot;
    });
  }

  Map<String, dynamic> _analyticsParameters(
      {PlotEntity plot, CropEntity crop, StageEntity stage}) {
    Map<String, dynamic> parameters = {};
    if (plot != null) {
      parameters.addAll({
        _AnalyticsNames.plotTitle: plot.title,
        _AnalyticsNames.plotScoreParameter: plot.score ?? 0
      });
    }
    if (crop != null) {
      parameters.addAll({
        _AnalyticsNames.cropNameParameter: crop.name,
        _AnalyticsNames.cropIdParameter: crop.uri
      });
    }
    if (stage != null) {
      parameters.addAll({
        _AnalyticsNames.stageTitleParameter: stage.article.title,
        _AnalyticsNames.stageIdParameter: stage.article.uri
      });
    }
    return parameters;
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
        castListOrNull<Map>(plotDocument.data[PlotEntityFields.stages]);
    return Future.wait(stages.map((stage) {
      final articlePath =
          castOrNull<String>(stage[PlotEntityFields.articlePath]);
      final started = castOrNull<Timestamp>(stage[PlotEntityFields.started]);
      final ended = castOrNull<Timestamp>(stage[PlotEntityFields.ended]);
      final id = castOrNull<String>(stage[PlotEntityFields.id]);
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

  PlotEntity _revertStage(PlotEntity forPlot, StageEntity stage) {
    final stageIndex = forPlot.stages.indexOf(stage);
    forPlot = _replaceStage(
        forPlot,
        stage,
        _stageWithDates(
          stage,
          stage.started,
          null,
        ));
    for (var i = stageIndex + 1; i < forPlot.stages.length; i++) {
      final upcomingStage = forPlot.stages[i];
      forPlot = _replaceStage(
          forPlot,
          upcomingStage,
          _stageWithDates(
            upcomingStage,
            null,
            null,
          ));
    }
    return forPlot;
  }

  PlotEntity _replaceStage(
      PlotEntity forPlot, StageEntity oldStage, StageEntity newStage) {
    final stageIndex = forPlot.stages.indexOf(oldStage);
    var newStages = List<StageEntity>.from(forPlot.stages);
    newStages.replaceRange(stageIndex, stageIndex + 1, [newStage]);
    return PlotEntity(
      uri: forPlot.uri,
      title: forPlot.title,
      crop: forPlot.crop,
      score: forPlot.score,
      stages: newStages,
    );
  }

  StageEntity _stageWithDates(
    StageEntity stage,
    DateTime start,
    DateTime end,
  ) {
    return StageEntity(
      id: stage.id,
      article: stage.article,
      started: start,
      ended: end,
    );
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
