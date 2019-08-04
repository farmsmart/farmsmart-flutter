import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/bloc/plot/StageBusinessLogic.dart';
import 'package:farmsmart_flutter/model/model/StageEntity.dart';
import 'package:farmsmart_flutter/model/model/PlotEntity.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/playground/styles/stage_card_styles.dart';
import 'package:intl/intl.dart';

class _Strings {
  static final stage = "Stage";

  static final inProgress = "In Progress";
  static final upcoming = "Upcoming";
  static final complete = "Complete";

  static final completeAction = "Completed";
  static final revertAction = "Revert to In Progress";
  static final readyAction = "Begin Stage";
  static final upcomingAction = "Please complete previous";
  static final inProgressAction = "Mark as complete";
}

class StageToStageCardViewModel
    implements ObjectTransformer<StageEntity, StageCardViewModel> {
  final PlotEntity _plot;
  final Function _beginAction;
  final Function _completeAction;
  final Function _revertAction;
  final StageBusinessLogic _logic = StageBusinessLogic();

  StageToStageCardViewModel(
      this._plot, this._beginAction, this._completeAction, this._revertAction);

  @override
  StageCardViewModel transform({StageEntity from}) {
    final stageNumber = _plot.stages.indexOf(from) + 1;
    final subtitle =
        Intl.message(_Strings.stage) + " " + stageNumber.toString();
    final status = _logic.status(from);
    return StageCardViewModel(
        title: from.article.title,
        subtitle: subtitle,
        statusTitle: _statusTitle(status),
        actionText: _actionTitle(status, from),
        action: _action(status, from),
        style: _cardStyle(status, from));
  }

  StageCardStyle _cardStyle(StageStatus status, StageEntity stage) {
    switch (status) {
      case StageStatus.inProgress:
        return StageCardStyles.buildInProgressStageStyle();
        break;
      case StageStatus.complete:
        return StageCardStyles.buildCompleteStageStyle();
        break;
      default:
        return _logic.canBegin(stage, _plot.stages)
            ? StageCardStyles.buildReadyToStartStageStyle()
            : StageCardStyles.buildUpcomingStageStyle();
    }
  }

  String _actionTitle(StageStatus status, StageEntity stage) {
    switch (status) {
      case StageStatus.inProgress:
        return Intl.message(_Strings.inProgressAction);
        break;
      case StageStatus.complete:
        return _logic.canRevert(stage, _plot.stages)
            ? Intl.message(_Strings.revertAction)
            : Intl.message(_Strings.completeAction);
        break;
      default:
        return _logic.canBegin(stage, _plot.stages)
            ? Intl.message(_Strings.readyAction)
            : Intl.message(_Strings.upcomingAction);
    }
  }

  Function _action(StageStatus status, StageEntity stage) {
    if (_logic.canBegin(stage, _plot.stages)) {
      return () => _beginAction(_plot, stage);
    } else if (_logic.canComplete(stage, _plot.stages)) {
      return () => _completeAction(_plot, stage);
    } else if (_logic.canRevert(stage, _plot.stages)) {
      return () => _revertAction(_plot, stage);
    }
    return null;
  }

  String _statusTitle(StageStatus status) {
    switch (status) {
      case StageStatus.inProgress:
        return Intl.message(_Strings.inProgress);
        break;
      case StageStatus.complete:
        return Intl.message(_Strings.complete);
        break;
      default:
        return Intl.message(_Strings.upcoming);
    }
  }
}
