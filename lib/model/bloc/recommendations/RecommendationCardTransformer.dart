import 'package:farmsmart_flutter/model/bloc/recommendations/RecommendationEngine.dart';
import 'package:farmsmart_flutter/model/entities/crop_entity.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/recommendation_card_view_model.dart';
import 'package:intl/intl.dart';

import '../Basket.dart';
import '../Transformer.dart';

class _Constants {
  static final cent = 100.0;
}

class _LocalisedStrings {
  static String match() => Intl.message('Match');

  static String viewDetails() => Intl.message('View Details');

  static String add() => Intl.message('Add to Plot');

  static String added() => Intl.message('Added');
}

class RecommendationCardTransformer
    extends ObjectTransformer<CropEntity, RecommendationCardViewModel> {
  final RecommendationEngine _engine;
  final Map<String,String> _ratingLookup;
  final Map<String, Map<String,String>> _plotInfo;
  final Basket<CropEntity> _basket;
  final double _heroThreshold;
  final Function _detailProvider;

  RecommendationCardTransformer({
    RecommendationEngine engine,
    Map<String,String> ratingLookup,
    Map<String, Map<String,String>> plotInfo,
    Basket<CropEntity> basket,
    Function provider,
    double heroThreshold,
  })  : this._engine = engine,
        this._plotInfo = plotInfo,
        this._ratingLookup = ratingLookup,
        this._basket = basket,
        this._detailProvider = provider,
        this._heroThreshold = heroThreshold;

  @override
  RecommendationCardViewModel transform({CropEntity from}) {
    final recommendationName = _ratingLookup[from.uri] ?? from.name;
    final score = _engine.recommend(recommendationName, _plotInfo);
    final percent = score * _Constants.cent;
    final subtitle =
        percent.toInt().toString() + "% " + _LocalisedStrings.match();
    final inBasket = _basket.contains(from);
    final addAction = inBasket ? () => {} : () => _basket.addItem(from);
    final isHero = score >= _heroThreshold;
    return RecommendationCardViewModel(
      title: from.name,
      subtitle: subtitle,
      description: from.article.summary,
      detailActionText: _LocalisedStrings.viewDetails(),
      detailProvider: _detailProvider(from),
      addActionText:
          inBasket ? _LocalisedStrings.added() : _LocalisedStrings.add(),
      addAction: addAction,
      imageProvider: CropImageProvider(from),
      isAdded: inBasket,
      isHero: isHero,
      score: score,
    );
  }
}
