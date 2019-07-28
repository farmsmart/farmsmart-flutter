import 'package:farmsmart_flutter/data/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_detail_listitem/mock_recommendation_detail_listitem_view_model.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';

import '../Transformer.dart';

class _Constants {

}

class _Strings {

}

class CropDetailTransformer
    implements ObjectTransformer<CropEntity, CropDetailViewModel> {
  @override
  CropDetailViewModel transform({CropEntity from}) {
    final detail = ArticleDetailViewModelTransformer();
    return CropDetailViewModel.fromArticle(detail.transform(from: from.article),[MockRecommendationDetailListItemViewModel.buildWithLargeColorList()]);
  }
}
