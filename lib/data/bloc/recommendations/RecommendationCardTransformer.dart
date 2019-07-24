import 'package:farmsmart_flutter/data/bloc/recommendations/RecommendationEngine.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_card/recommendation_card.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

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

  RecommendationCardTransformer(RecommendationEngine engine): this._engine = engine;
  @override
  RecommendationCardViewModel transform({CropEntity from}) {
    final percent = _engine.recommend(from.id) * _Constants.cent;
    final subtitle =
        percent.toInt().toString() + "% " + Intl.message(_Strings.match);
    return RecommendationCardViewModel(
      title: from.name,
      subtitle: subtitle,
      description: from.summary,
      leftActionText: Intl.message(_Strings.viewDetails),
      rightActionText: Intl.message(_Strings.add),
      image:  NetworkImage('http://www.freemagebank.com/wp-content/uploads/edd/2015/07/GL0000302LR.jpg'),
    );
  }
}
