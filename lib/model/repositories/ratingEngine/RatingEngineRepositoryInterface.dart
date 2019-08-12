import 'package:farmsmart_flutter/model/model/FactorEntity.dart';

abstract class RatingEngineRepositoryInterface {
    Future<Map<String, Map<String, double>>> getWeights();
    Stream<Map<String, Map<String, double>>> observeWeights();
    Future<Map<String, Map<String, Map<String, double>>>> getFactors();
    Stream<Map<String, Map<String, Map<String, double>>>> observeFactors();
}