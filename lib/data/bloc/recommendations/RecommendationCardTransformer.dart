import 'package:farmsmart_flutter/data/bloc/recommendations/RecommendationEngine.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_card/recommendation_card.dart';
import 'package:intl/intl.dart';

import '../Basket.dart';
import '../Transformer.dart';

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

  RecommendationCardTransformer({RecommendationEngine engine, Basket<CropEntity> basket,}): this._engine = engine, this._basket = basket;
  @override
  RecommendationCardViewModel transform({CropEntity from}) {
    final percent = _engine.recommend(from.id) * _Constants.cent;
    final subtitle =
        percent.toInt().toString() + "% " + Intl.message(_Strings.match);
    final inBasket = _basket.contains(from);
    final rightAction = inBasket ? () => {} : () => _basket.addItem(from);
    return RecommendationCardViewModel(
      title: from.name,
      subtitle: subtitle,
      description: from.summary,
      detailActionText: Intl.message(_Strings.viewDetails),
      addActionText: inBasket ? Intl.message(_Strings.added) :Intl.message(_Strings.add),
      addAction: rightAction,
      image:  CropImageProvider(from).urlToFit(),
      isAdded: inBasket,
    );
  }
}
