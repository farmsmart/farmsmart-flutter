import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/entities/PlotEntity.dart';
import 'package:farmsmart_flutter/model/entities/StageEntity.dart';
import 'package:farmsmart_flutter/model/entities/crop_entity.dart';

class _Fields {
  static const title = "title";
  static const score = "score";
  static const stages = "stages";
  static const cropPath = "cropPath";
  static const articlePath = "articlePath";

  static const started = "started";
  static const ended = "ended";
  static const id = "id";
}

class DocumentToPlotEntityTransformer
    extends ObjectTransformer<DocumentSnapshot, PlotEntity> {

  DocumentToPlotEntityTransformer();
      
  @override
  PlotEntity transform({DocumentSnapshot from, CropEntity crop, List<StageEntity> stages,}) {
    final data = from.data;
    final title = castOrNull<String>(data[_Fields.title]);
    final score = castOrNull<double>(data[_Fields.score]);
    final uri = from.reference.path;
    return PlotEntity(
      uri: uri,
      title: title,
      crop: crop,
      score: score,
      stages: stages,
    );
  }

  String cropURI({DocumentSnapshot from}) {
     final data = from.data;
    return castOrNull<String>(data[_Fields.cropPath]);
  }
}

class PlotEntityToDocumentTransformer
    extends ObjectTransformer<PlotEntity, Map<String, dynamic>> {
  @override
  Map<String, dynamic> transform({PlotEntity from}) {

  
    return {
      _Fields.title: from.title,
      _Fields.score: from.score,
      _Fields.cropPath: from.crop.uri,
      _Fields.stages: _transformStagesToFirebase(from),
    };
  }

  List<Map<String, dynamic>> _transformStagesToFirebase(PlotEntity from) {
      return from.stages.map((stage){
          return {
          _Fields.id: stage.article.uri, //LH the stages need a id (in the plot context), since they are linked to the article 1 to 1 we can use the article uri
          _Fields.articlePath: stage.article.uri,
          _Fields.started: (stage.started != null ) ? Timestamp.fromDate(stage.started) : null,
          _Fields.ended: (stage.ended != null ) ? Timestamp.fromDate(stage.ended) : null,
          };
      }).toList();
  }
}
