import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/repositories/ratingEngine/RatingEngineRepositoryInterface.dart';

class _Fields {
  static const scores = "scores";
  static const factor = "factor";
  static const weight = "weight";
  static const values = "values";
  static const subject = "crop";
  static const factorKey = "key";
  static const factorValue = "rating";
  static const name = "name";
}

class FirebaseToRatingInfoTransformer
    extends ObjectTransformer<QuerySnapshot, Map<String, RatingInfo>> {
  @override
  Map<String, RatingInfo> transform({QuerySnapshot from}) {
    Map<String, RatingInfo> ratingData = {};
    final documents = from.documents;
    documents.forEach((ratingEntry) {
      final subject = (ratingEntry.data[_Fields.subject] != null)
          ? ratingEntry.data[_Fields.subject][_Fields.name]
          : null;
      if (subject != null) {
        final scores = castListOrNull<Map>(ratingEntry.data[_Fields.scores]);
        Map<String, double> outputWeights = {};
        Map<String, Map<String, double>> outputFactors = {};
        scores.forEach((score) {
          final factorName = score[_Fields.factor];
          final weight = score[_Fields.weight];
          final factorValues = castListOrNull<Map>(score[_Fields.values]);
          factorValues.forEach((factor) {
            final factorKey = factor[_Fields.factorKey];
            final factorValue = factor[_Fields.factorValue];
            if (outputFactors[factorName] == null) {
              outputFactors[factorName] = {};
            }
            outputFactors[factorName][factorKey] = factorValue.toDouble();
          });
          outputWeights[factorName] = weight;
        });
        ratingData[subject] = RatingInfo(outputWeights, outputFactors);
      }
    });
    return ratingData;
  }
}
