/*
  This class will normalise the input weightMatrix to unit (0-1) terms based on the total maginitude of the weights in the set. 
  It will also normalise the input factors using the inputScale.
  This enables the recomendation calculation to be a simple multiple and sum.
  It will output a normalised value in unit terms (0-1)
*/

class RecommendationEngine {
  final Map<String, double> _inputFactors;
  final Map<String, Map<String, double>> _scoringFactors;

  RecommendationEngine._(Map<String, double> inputFactors,
      Map<String, Map<String, double>> scoringFactors)
      : this._inputFactors = inputFactors,
        this._scoringFactors = scoringFactors;

  factory RecommendationEngine(Map<String, double> inputFactors,
      double inputScale, Map<String, Map<String, double>> weightMatrix) {
    final scoringFactors = weightMatrix.map((entity, weights) {
      final totalWeight = weights.values.reduce((a, b) {
        return a + b;
      });
      return MapEntry(entity, _normalise(weights, totalWeight));
    });

    final normalInput = _normalise(inputFactors, inputScale);
    return RecommendationEngine._(normalInput, scoringFactors);
  }

  double recommend(String entity) {
    double score = 0;
    final scoringMatrix = _scoringFactors[entity];
    if (scoringMatrix != null) {
      for (var key in _inputFactors.keys) {
        score += _inputFactors[key] * scoringMatrix[key] ?? 0;
      }
    }
    return score;
  }

  static Map<String, double> _normalise(
      Map<String, double> values, double scale) {
    if (values == null) {
      return null;
    }
    return values.map((key, value) {
      return MapEntry(key, (1.0 / scale) * value);
    });
  }
}
