


class RecommendationEngine {
  final Map<String,double> _inputFactors;
  final Map<String, Map<String,double>> _weightMatrix;
  final double _inputScale;

  RecommendationEngine(Map<String,double> inputFactors, double inputScale,  Map<String, Map<String,double>> weightMatrix): this._inputFactors = inputFactors, this._inputScale = inputScale, this._weightMatrix = weightMatrix;

  double recommend(String entity){
    double score = 0;
    final weights = _weightMatrix[entity];
    final totalWeight = weights.values.reduce((a,b) {
      return a + b;
    });
    final scoringFactors = _normalise(weights, totalWeight);
    final inputFactors = _normalise(_inputFactors, _inputScale);
    if (scoringFactors != null) {
       for (var key in inputFactors.keys) {
        score += inputFactors[key] * scoringFactors[key] ?? 0; 
      }
    }
    return score;
  }

  Map<String,double> _normalise(Map<String,double> values, double scale) {
    if( values == null)
    {
      return null;
    }
    return values.map((key,value){
        return MapEntry(key, (1.0 / scale) * value);
    });
  }

}