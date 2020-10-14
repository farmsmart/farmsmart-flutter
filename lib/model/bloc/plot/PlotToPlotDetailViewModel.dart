import 'package:farmsmart_flutter/model/bloc/StaticViewModelProvider.dart';
import 'package:farmsmart_flutter/model/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/model/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/model/bloc/crop/CropDetailTransformer.dart';
import 'package:farmsmart_flutter/model/entities/PlotEntity.dart';
import 'package:farmsmart_flutter/model/entities/crop_entity.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';
import 'package:intl/intl.dart';

import '../Transformer.dart';
import 'PlotToPlotListItemViewModel.dart';
import 'StageBusinessLogic.dart';
import 'StageToStageCardViewModel.dart';

class _LocalisedStrings {
  static String relatedArticles() => Intl.message('Related articles');

  static String viewMore() => Intl.message('View more on the Web');

  static String discoverMuchMore() =>
      Intl.message('Discover much more information using this link...');
}

class PlotToPlotDetailViewModel
    extends ObjectTransformer<PlotEntity, PlotDetailViewModel> {
  final _articleTransformer =
      ArticleListItemViewModelTransformer.buildWithDetail(
    ArticleDetailViewModelTransformer(
      relatedTitle: _LocalisedStrings.relatedArticles(),
      contentLinkTitle: _LocalisedStrings.viewMore(),
      contentLinkDescription: _LocalisedStrings.discoverMuchMore(),
    ),
  );
  final _cropTransformer = CropDetailTransformer();
  final StageToStageCardViewModel _stageTransformer;
  final Function _renameAction;
  final Function _removeAction;
  final PlotEntity _plot;
  final _logic = StageBusinessLogic();

  PlotToPlotDetailViewModel(
    this._plot,
    this._stageTransformer,
    this._renameAction,
    this._removeAction,
  );

  @override
  PlotDetailViewModel transform({PlotEntity from}) {
    if (from != null) {
      assert(from == _plot);
    }
    final headerViewModel =
        PlotToPlotListItemViewModel(null).transform(from: _plot);
    final stageViewModels = _plot.stages.map((stage) {
      return _stageTransformer.transform(from: stage);
    }).toList();
    final List<ArticleDetailViewModel> articleViewModels =
        _plot.stages.map((stage) {
      return _articleTransformer.transform(from: stage.article).detailViewModel;
    }).toList();

    final cropDetailModel = _cropTransformer.transform(from: _plot.crop);
    final detailProvider = StaticViewModelProvider(cropDetailModel);
    return PlotDetailViewModel(
        title: headerViewModel.title,
        detailText: headerViewModel.detail,
        imageProvider: CropImageProvider(_plot.crop),
        progress: headerViewModel.progress,
        stageCardViewModels: stageViewModels,
        stageArticleViewModels: articleViewModels,
        currentStage: _logic.currentStageIndex(_plot.stages),
        remove: () => _removeAction(_plot),
        rename: _rename,
        detailProvider: detailProvider);
  }

  _rename(String name) {
    _renameAction(_plot, name);
  }
}
