import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/bloc/plot/PlotDetailProvider.dart';
import 'package:farmsmart_flutter/model/bloc/plot/StageBusinessLogic.dart';
import 'package:farmsmart_flutter/model/entities/PlotEntity.dart';
import 'package:farmsmart_flutter/model/entities/crop_entity.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';
import 'package:intl/intl.dart';

class _LocalisedStrings {
  static String day() => Intl.message('Day');
  static String upcoming() => Intl.message('Upcoming');
}

class PlotToPlotListItemViewModel extends ObjectTransformer<PlotEntity, PlotListItemViewModel> {
  final _logic = StageBusinessLogic();
  final PlotDetailProvider _detailProvider;

  PlotToPlotListItemViewModel(this._detailProvider);

  @override
  PlotListItemViewModel transform({PlotEntity from}) {
    final title = from.title;
    final detailText = _detailString(from: from);
    final progress = _logic.progress(from.stages);
    return PlotListItemViewModel(
        title: title,
        subtitle: _subtitleString(from: from),
        detail: detailText,
        progress: progress,
        provider: _detailProvider,
        imageProvider: CropImageProvider(from.crop));
  }

  String _subtitleString({PlotEntity from}) {
    return _logic.currentStage(from.stages).article.title;
  }

  String _detailString({PlotEntity from}) {
    final firstStage = from.stages.first;
    final started = firstStage.started;
    if (started != null) {
      final day = _logic.daysSinceStarted(from.stages) + 1; //the day we are on, so + 1 on days since started (0 = 1, 1 = 2 ....)
      return _LocalisedStrings.day() + " " + day.toString();
    }
    return _LocalisedStrings.upcoming();
  }

}
