import 'package:farmsmart_flutter/model/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/model/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/model/enums.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_detail_listitem/recommendation_detail_listitem.dart';
import 'package:intl/intl.dart';
import '../Transformer.dart';

class _LocalisedStrings {
  static String bestSoil() => Intl.message('Best Soil');

  static String waterFrequency() => Intl.message('Water Frequency');

  static String low() => Intl.message('Low');

  static String medium() => Intl.message('Medium');

  static String high() => Intl.message('High');
}

class _Strings {
  static const listSeparator = ", ";
}

class _Icons {
  static const soil = 'assets/icons/detail_icon_best_soil.png';
  static const companion = 'assets/icons/detail_icon_companion.png';
  static const complexity = 'assets/icons/detail_icon_complexity.png';
  static const nonCompanion = 'assets/icons/detail_icon_non_companion.png';
  static const type = 'assets/icons/detail_icon_crop_type.png';
  static const water = 'assets/icons/detail_icon_water.png';
  static const cost = 'assets/icons/detail_icon_setup_costs.png';
}

class CropDetailTransformer
    implements ObjectTransformer<CropEntity, CropDetailViewModel> {
  @override
  CropDetailViewModel transform({CropEntity from}) {
    final detail = ArticleDetailViewModelTransformer();
    return CropDetailViewModel.fromArticle(
      detail.transform(from: from.article),
      [_soilType(from), _waterFrequency(from)],
    );
  }

  RecommendationDetailListItemViewModel _soilType(CropEntity from) {
    final typesString = (from.soilType.isNotEmpty)
        ? from.soilType.reduce((a, b) {
            return a + _Strings.listSeparator + b;
          })
        : "";
    return RecommendationDetailListItemViewModel(
        iconPath: _Icons.soil,
        title: _LocalisedStrings.bestSoil(),
        subtitle: typesString);
  }

  RecommendationDetailListItemViewModel _waterFrequency(CropEntity from) {
    return RecommendationDetailListItemViewModel(
        iconPath: _Icons.water,
        title: _LocalisedStrings.waterFrequency(),
        subtitle: _loHiToString(from.waterRequirement));
  }

  String _loHiToString(LoHi value) {
    switch (value) {
      case LoHi.LOW:
        return _LocalisedStrings.low();
        break;
      case LoHi.MEDIUM:
        return _LocalisedStrings.medium();
        break;
      case LoHi.HIGH:
        return _LocalisedStrings.high();
    }
    return "";
  }
}
