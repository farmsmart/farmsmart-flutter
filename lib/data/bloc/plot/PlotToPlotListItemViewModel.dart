import 'package:farmsmart_flutter/data/bloc/Transformer.dart';
import 'package:farmsmart_flutter/data/bloc/plot/StageBusinessLogic.dart';
import 'package:farmsmart_flutter/data/model/PlotEntity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';
import 'package:intl/intl.dart';

class _Strings {
  static const day = "Day";
  static const upcoming = "Upcoming";
}

class PlotToPlotListItemViewModel implements ObjectTransformer<PlotEntity, PlotListItemViewModel> {
  @override
  PlotListItemViewModel transform({PlotEntity from}) {
    return PlotListItemViewModel(title: from.title, subtitle:_subtitleString(from: from), detail: _detailString(from: from), imageProvider: CropImageProvider(from.crop) );
  }

  String _subtitleString({PlotEntity from}) {
    final logic = StageBusinessLogic(from.stages);
    return logic.currentStage().article.title;
  }

  String _detailString({PlotEntity from}) {
    final logic = StageBusinessLogic(from.stages);
    final started = logic.currentStage().started;
    if (started != null) {
       final daysSinceStarted = DateTime.now().difference(started).inDays;
      return Intl.message(_Strings.day) + " " + daysSinceStarted.toString();
    }
    return Intl.message(_Strings.upcoming) ;
  }
}