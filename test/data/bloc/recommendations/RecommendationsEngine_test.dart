import 'package:farmsmart_flutter/model/bloc/recommendations/RecommendationEngine.dart';
import 'package:test/test.dart';

final inputScale = 10.0;

/*final testInput = {"Location":10.0,"Land Size":4.0, "Soil Type":9.0, "Irrigation":10.0,"Season":5.0,"Intention":7.0};
final testWeights = {"Tomatoes":{"Location":0.2,"Land Size":0.16, "Soil Type":0.2, "Irrigation":0.2,"Season":0.02,"Intention":0.2},
                          "Okra":{"Location":0.12,"Land Size":0.18, "Soil Type":0.18, "Irrigation":0.12,"Season":0.18,"Intention":0.20}};

*/
final cowpeasInput = {
  "Skill Level": 1.0,
  "Location": 9.0,
  "Agrozone": 9.0,
  "Land Size": 3.0,
  "Soil Type": 10.0,
  "Irrigation": 7.0,
  "Month": 6.0,
  "Intention": 10.0,
};

final chilliesInput = {
  "Skill Level": 1.0,
  "Location": 3.0,
  "Agrozone": 9.0,
  "Land Size": 3.0,
  "Soil Type": 5.0,
  "Irrigation": 10.0,
  "Month": 7.0,
  "Intention": 7.0,
};


final maxInput = {
  "Skill Level": 10.0,
  "Location": 10.0,
  "Agrozone": 10.0,
  "Land Size": 10.0,
  "Soil Type": 10.0,
  "Irrigation": 10.0,
  "Month": 10.0,
  "Intention": 10.0,
};

final harryWeights = {
  "Cowpeas": {
    "Skill Level": 0.1,
    "Location": 0.1,
    "Agrozone": 0.1,
    "Land Size": 0.1,
    "Soil Type": 0.1,
    "Irrigation": 0.1,
    "Month": 0.1,
    "Intention": 0.1,
  },
  "Chillies": {
    "Skill Level": 0.8,
    "Location": 0.1,
    "Agrozone": 0.1,
    "Land Size": 0.9,
    "Soil Type": 0.7,
    "Irrigation": 0.7,
    "Month": 0.3,
    "Intention": 0.9,
  },
  "max": {
    "Skill Level": 1.0,
    "Location": 1.0,
    "Agrozone": 1.0,
    "Land Size": 1.0,
    "Soil Type": 1.0,
    "Irrigation": 1.0,
    "Month": 1.0,
    "Intention": 1.0,
  }
};

void main() {
  test('Harry Input recommendation', () {
    final chilliesEngine = RecommendationEngine(
        inputFactors: chilliesInput,
        inputScale: inputScale,
        weightMatrix: harryWeights);

    final cowpeasEngine = RecommendationEngine(
        inputFactors: cowpeasInput,
        inputScale: inputScale,
        weightMatrix: harryWeights);

    final maxEngine = RecommendationEngine(
        inputFactors: maxInput,
        inputScale: inputScale,
        weightMatrix: harryWeights);
        
    final chillies = chilliesEngine.recommend("Chillies");
    final cowPeas = cowpeasEngine.recommend("Cowpeas");
    final max = maxEngine.recommend("max");
    //TODO: add harry test data........
    expect(max, 1.0);
  });
}
