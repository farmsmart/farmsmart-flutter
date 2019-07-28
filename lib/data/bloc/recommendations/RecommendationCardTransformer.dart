import 'package:farmsmart_flutter/data/bloc/recommendations/RecommendationEngine.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_card/recommendation_card_view_model.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';
import 'package:intl/intl.dart';

import '../Basket.dart';
import '../Transformer.dart';
import '../ViewModelProvider.dart';

class _Constants {
  static final cent = 100.0;
}

class _Strings {
  static final match = "Match";
  static final viewDetails = "View Details";
  static final add = "Add to Plot";
  static final added = "Added";
}

class RecommendationCardTransformer
    implements ObjectTransformer<CropEntity, RecommendationCardViewModel> {
  final RecommendationEngine _engine;
  final Basket<CropEntity> _basket;
  final Function _isHero;
  final Function _detailProvider;

  RecommendationCardTransformer({RecommendationEngine engine, Basket<CropEntity> basket, Function provider, Function isHero,}): this._engine = engine, this._basket = basket, this._detailProvider = provider, this._isHero = isHero;
  @override
  RecommendationCardViewModel transform({CropEntity from}) {
    final score = _engine.recommend(from.id);
    final percent = score * _Constants.cent;
    final subtitle =
        percent.toInt().toString() + "% " + Intl.message(_Strings.match);
    final inBasket = _basket.contains(from);
    final rightAction = inBasket ? () => {} : () => _basket.addItem(from);

    return RecommendationCardViewModel(
      title: from.name,
      subtitle: subtitle,
      description: from.article.summary,
      detailActionText: Intl.message(_Strings.viewDetails),
      detailProvider: _detailProvider(from),
      addActionText: inBasket ? Intl.message(_Strings.added) :Intl.message(_Strings.add),
      addAction: rightAction,
      image:  CropImageProvider(from).urlToFit(),
      isAdded: inBasket,
      isHero: _isHero(from),
      score: score,
    );
  }
}
