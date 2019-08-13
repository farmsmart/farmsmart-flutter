import 'package:farmsmart_flutter/model/bloc/recommendations/RecommendationEngine.dart';
import 'package:farmsmart_flutter/model/model/mock/MockRecommendation.dart';
import 'package:test/test.dart';

final _inputScale = 10.0;
final _plotInput = {
  "Skill Level": "hi",
  "Location": "lo",
  "Agrozone": "med",
};

void main() {
  test('Harry Input recommendation', () {
    final chilliesEngine = RecommendationEngine(
      inputFactors: harryInputFactors,
      inputScale: _inputScale,
      weightMatrix: harryWeights,
    );

    final chillies = chilliesEngine.recommend("Chillies", _plotInput);
    final clampedToUnit = (chillies >= 0) && (chillies <= 1.0);
    final highlyRecommended = (chillies >= 0.8); 
    expect(clampedToUnit, true);
    expect(highlyRecommended, true);
  });
}
