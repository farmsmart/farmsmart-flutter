import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/bloc/plot/PlotDetailProvider.dart';
import 'package:farmsmart_flutter/model/bloc/plot/StageBusinessLogic.dart';
import 'package:farmsmart_flutter/model/model/PlotEntity.dart';
import 'package:farmsmart_flutter/model/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';
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
    final progress = _logic.progress(from.stages);
    return PlotListItemViewModel(title: title, subtitle:_subtitleString(from: from), detail: detailText, progress: progress, provider: _detailProvider, imageProvider: CropImageProvider(from.crop) );
  }

  String _subtitleString({PlotEntity from}) {
    return _logic.currentStage(from.stages).article.title;
  }

  String _detailString({PlotEntity from}) {
    final firstStage = from.stages.first;
    final started = firstStage.started;
    if (started != null) {
       final daysSinceStarted = _logic.daysSinceStarted(from.stages);
      return Intl.message(_Strings.day) + " " + daysSinceStarted.toString();
    }
    return Intl.message(_Strings.upcoming) ;
  }
}