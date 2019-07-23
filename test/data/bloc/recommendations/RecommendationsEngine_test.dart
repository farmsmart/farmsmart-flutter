
import 'package:farmsmart_flutter/data/bloc/recommendations/RecommendationEngine.dart';
import 'package:test/test.dart';


final inputScale = 10.0;

final testInput = {"Location":10.0,"Land Size":4.0, "Soil Type":9.0, "Irrigation":10.0,"Season":5.0,"Intention":7.0};
final testWeights = {"Tomatoes":{"Location":0.2,"Land Size":0.16, "Soil Type":0.2, "Irrigation":0.2,"Season":0.02,"Intention":0.2},
                          "Okra":{"Location":0.12,"Land Size":0.18, "Soil Type":0.18, "Irrigation":0.12,"Season":0.18,"Intention":0.20}};

void main() {
  test('Harry Input recommendation', () {
    final engine = RecommendationEngine(testInput, inputScale, testWeights); 
    final tomatoes = engine.recommend("Tomatoes");
    final okra = engine.recommend("Okra");
    expect(tomatoes > okra, true);
  });
}