/*
  This class will normalise the input weightMatrix to unit (0-1) terms based on the total maginitude of the weights in the set. 
  It will also normalise the input factors using the inputScale.
  This enables the recomendation calculation to be a simple multiple and sum.
  It will output a normalised value in unit terms (0-1)
*/



class _Constants {
  static const unit = 1.0;
  static const defaultScore = 0.0;
}

class _Fields {
  static final id = "id";
}

class RecommendationEngine {
  final Map<String, Map<String, Map<String, double>>>
      _inputFactors; // _inputFactors["tomatoes"]["Skill level"]["beginner"]
  final Map<String, Map<String, double>>
      _weightingFactors; // _weightingFactors["tomatoes"]["Skill level"]

  RecommendationEngine._(
      Map<String, Map<String, Map<String, double>>> inputFactors,
      Map<String, Map<String, double>> weightingFactors)
      : this._inputFactors = inputFactors,
        this._weightingFactors = weightingFactors;

  factory RecommendationEngine(
      {Map<String, Map<String, Map<String, double>>> inputFactors,
      double inputScale = 1.0,
      Map<String, Map<String, double>> weightMatrix}) {
    final normalisedWeights = weightMatrix.map((subject, weights) {
      final totalWeight = weights.values.reduce((a, b) {
        return a + b;
      });
      return MapEntry(subject, _normalise(weights, totalWeight));
    });

    final normalisedInputs = inputFactors.map((subject, factorLookup) {
      return MapEntry(subject, factorLookup.map((factorName, valueLookup) {
        return MapEntry(factorName, _normalise(valueLookup, inputScale));
      }));
    });

    return RecommendationEngine._(normalisedInputs, normalisedWeights);
  }

  double recommend(String subject, Map<String, Map<String, String>> plotInfo) {
    double score = _Constants.defaultScore;
    final weightMatrix = _weightingFactors[subject];
    final inputMatrix = _inputFactors[subject];
    if (weightMatrix != null) {
      for (var key in inputMatrix.keys) {
        final subjectInput = inputMatrix[key];
        final subjectWeighting = weightMatrix[key] ?? _Constants.defaultScore;
        final plotInput = plotInfo[key];
        final plotInputOption = plotInput != null ? plotInput[_Fields.id] : null;
        if ((subjectInput != null) && (plotInputOption != null)) {
          score += (subjectInput[plotInputOption] ?? 0.0) * subjectWeighting;
        }
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
      return MapEntry(key, (_Constants.unit / scale) * value);
    });
  }
}
