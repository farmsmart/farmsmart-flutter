import 'package:farmsmart_flutter/data/bloc/Transformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/plot/PlotDetailProvider.dart';
import 'package:farmsmart_flutter/data/bloc/plot/StageBusinessLogic.dart';
import 'package:farmsmart_flutter/data/bloc/plot/StageToStageCardViewModel.dart';
import 'package:farmsmart_flutter/data/model/PlotEntity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';
import 'package:intl/intl.dart';

class _Strings {
  static const day = "Day";
  static const upcoming = "Upcoming";
}

class PlotToPlotListItemViewModel implements ObjectTransformer<PlotEntity, PlotListItemViewModel> {

  final _logic = StageBusinessLogic();
  final PlotDetailProvider _detailProvider;
  PlotToPlotListItemViewModel(this._detailProvider);

  @override
  PlotListItemViewModel transform({PlotEntity from}) {
    final title = from.title;
    final detailText = _detailString(from: from);
    return PlotListItemViewModel(title: title, subtitle:_subtitleString(from: from), detail: detailText, provider: _detailProvider, imageProvider: CropImageProvider(from.crop) );
  }

  String _subtitleString({PlotEntity from}) {
    return _logic.currentStage(from.stages).article.title;
  }

  String _detailString({PlotEntity from}) {
    final firstStage = from.stages.first;
    final started = firstStage.started;
    if (started != null) {
       final daysSinceStarted = DateTime.now().difference(started).inDays;
      return Intl.message(_Strings.day) + " " + daysSinceStarted.toString();
    }
    return Intl.message(_Strings.upcoming) ;
  }
}