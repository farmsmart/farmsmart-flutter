import 'package:farmsmart_flutter/model/bloc/recommendations/RecommendationEngine.dart';
import 'package:farmsmart_flutter/model/model/crop_entity.dart';
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
  final Basket<CropEntity> _basket;
  final Function _isHero;
  final Function _detailProvider;

  RecommendationCardTransformer({
    RecommendationEngine engine,
    Basket<CropEntity> basket,
    Function provider,
    Function isHero,
  })  : this._engine = engine,
        this._basket = basket,
        this._detailProvider = provider,
        this._isHero = isHero;

  @override
  RecommendationCardViewModel transform({CropEntity from}) {
    final score = _engine.recommend(from.id);
    final percent = score * _Constants.cent;
    final subtitle =
        percent.toInt().toString() + "% " + _LocalisedStrings.match();
    final inBasket = _basket.contains(from);
    final addAction = inBasket ? () => _basket.removeItem(from) : () => _basket.addItem(from);

    return RecommendationCardViewModel(
      title: from.name,
      subtitle: subtitle,
      description: from.article.summary,
      detailActionText: _LocalisedStrings.viewDetails(),
      detailProvider: _detailProvider(from),
      addActionText:
          inBasket ? _LocalisedStrings.added() : _LocalisedStrings.add(),
      addAction: addAction,
      image: CropImageProvider(from).urlToFit(),
      isAdded: inBasket,
      isHero: _isHero(from),
      score: score,
    );
  }
}
