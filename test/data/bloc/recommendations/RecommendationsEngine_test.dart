
import 'package:farmsmart_flutter/data/bloc/recommendations/RecommendationEngine.dart';
import 'package:test/test.dart';

final inputScale = 10.0;

/*final testInput = {"Location":10.0,"Land Size":4.0, "Soil Type":9.0, "Irrigation":10.0,"Season":5.0,"Intention":7.0};
final testWeights = {"Tomatoes":{"Location":0.2,"Land Size":0.16, "Soil Type":0.2, "Irrigation":0.2,"Season":0.02,"Intention":0.2},
                          "Okra":{"Location":0.12,"Land Size":0.18, "Soil Type":0.18, "Irrigation":0.12,"Season":0.18,"Intention":0.20}};

*/

final harryInput = {
"Skill Level":0.0,
"Locations":2.0,
"Agrozone":2.0,
"Land Size":6.0,
"Soil Type":5.0,
"Irrigation":8.0,
"Month":6.0,
"Intention":0.0,};
final harryWeights = {"Chillies": {
"Skill Level":0.4,
"Locations":0.3,
"Agrozone":0.3,
"Land Size":0.6,
"Soil Type":0.2,
"Irrigation":0.1,
"Month":0.9,
"Intention":0.8,
},};

void main() {
  test('Harry Input recommendation', () {
    final engine = RecommendationEngine(harryInput, inputScale, harryWeights); 
    final tomatoes = engine.recommend("Chillies");

    expect(true, true);
  });
}