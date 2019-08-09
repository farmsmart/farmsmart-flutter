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

  static String cropType() => Intl.message('Crop Type');

  static String complexity() => Intl.message('Complexity');

  static String setupCosts() => Intl.message('Setup Costs');

  static String profitability() => Intl.message('Profitability');

  static String companionPlants() => Intl.message('Companion Plants');

  static String nonCompanionPlants() => Intl.message('Non-Companion Plants');

  static String low() => Intl.message('Low');

  static String medium() => Intl.message('Medium');

  static String high() => Intl.message('High');

  static String single() => Intl.message('Single');

  static String rotation() => Intl.message('Rotation');

  static String beginner() => Intl.message('Beginner');

  static String advance() => Intl.message('Advance');

  static String intermediate() => Intl.message('Intermediate');
}

class _Strings {
  static const listSeparator = ', ';
  static const emptyString = '';
}

class _Icons {
  static const soil = 'assets/icons/detail_icon_best_soil.png';
  static const companion = 'assets/icons/detail_icon_companion.png';
  static const complexity = 'assets/icons/detail_icon_complexity.png';
  static const nonCompanion = 'assets/icons/detail_icon_non_companion.png';
  static const type = 'assets/icons/detail_icon_crop_type.png';
  static const water = 'assets/icons/detail_icon_water.png';
  static const cost = 'assets/icons/detail_icon_setup_costs.png';
  static const profitability = 'assets/icons/detail_icon_profitability.png';
}

class CropDetailTransformer
    extends ObjectTransformer<CropEntity, CropDetailViewModel> {
  @override
  CropDetailViewModel transform({CropEntity from}) {
    final detail = ArticleDetailViewModelTransformer();
    return CropDetailViewModel.fromArticle(
      detail.transform(from: from.article),
      [
        _soilType(from),
        _complexity(from),
        _waterFrequency(from),
        _cropType(from),
        _setupCosts(from),
        _profitability(from),
        _companionPlants(from),
        _nonCompanionPlants(from),
      ],
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

  RecommendationDetailListItemViewModel _complexity(CropEntity from) {
    return RecommendationDetailListItemViewModel(
        iconPath: _Icons.complexity,
        title: _LocalisedStrings.complexity(),
        subtitle: _complexityToString(from.complexity));
  }

  RecommendationDetailListItemViewModel _waterFrequency(CropEntity from) {
    return RecommendationDetailListItemViewModel(
        iconPath: _Icons.water,
        title: _LocalisedStrings.waterFrequency(),
        subtitle: _loHiToString(from.waterRequirement));
  }

  RecommendationDetailListItemViewModel _cropType(CropEntity from) {
    return RecommendationDetailListItemViewModel(
        iconPath: _Icons.type,
        title: _LocalisedStrings.cropType(),
        subtitle: _cropTypeToString(from.cropType));
  }

  RecommendationDetailListItemViewModel _setupCosts(CropEntity from) {
    return RecommendationDetailListItemViewModel(
        iconPath: _Icons.cost,
        title: _LocalisedStrings.setupCosts(),
        subtitle: _loHiToString(from.setupCost));
  }

  RecommendationDetailListItemViewModel _profitability(CropEntity from) {
    return RecommendationDetailListItemViewModel(
        iconPath: _Icons.profitability,
        title: _LocalisedStrings.profitability(),
        subtitle: _loHiToString(from.profitability));
  }

  RecommendationDetailListItemViewModel _companionPlants(CropEntity from) {
    return RecommendationDetailListItemViewModel(
      iconPath: _Icons.companion,
      title: _LocalisedStrings.companionPlants(),
      subtitle: from.companionPlants.join(_Strings.listSeparator),
    );
  }

  RecommendationDetailListItemViewModel _nonCompanionPlants(CropEntity from) {
    return RecommendationDetailListItemViewModel(
      iconPath: _Icons.nonCompanion,
      title: _LocalisedStrings.nonCompanionPlants(),
      subtitle: from.nonCompanionPlants.join(_Strings.listSeparator),
    );
  }

  String _cropTypeToString(CropType value) {
    switch (value) {
      case CropType.ROTATION:
        return _LocalisedStrings.rotation();
        break;
      case CropType.SINGLE:
        return _LocalisedStrings.single();
        break;
    }
    return _Strings.emptyString;
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
        break;
       default:
        return _Strings.emptyString;
    }
  }

  String _complexityToString(CropComplexity value) {
    switch (value) {
      case CropComplexity.BEGINNER:
        return _LocalisedStrings.beginner();
        break;
      case CropComplexity.INTERMEDIATE:
        return _LocalisedStrings.intermediate();
        break;
      case CropComplexity.ADVANCED:
        return _LocalisedStrings.advance();
        break;
      default:
        return _Strings.emptyString;
    }
  }
}
