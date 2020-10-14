
class RatingInfo {
  final Map<String, double> weights;
  final Map<String,  Map<String,double>> scores;

  RatingInfo(this.weights, this.scores);

  static Map<String,Map<String,double>> extractWeights(Map<String,RatingInfo> from) {
      return from.map((key,info){
          return MapEntry(key, info.weights);
      });
  }

  static Map<String,Map<String,Map<String,double>>> extractScores(Map<String,RatingInfo> from) {
      return from.map((key,info){
          return MapEntry(key, info.scores);
      });
  }
}

abstract class RatingEngineRepositoryInterface {
    Future<Map<String, RatingInfo>> getRatingInfo();
    Stream<Map<String, RatingInfo>> observeRatingInfo();
    Future<Map<String,String>> ratingNameLookup();
}