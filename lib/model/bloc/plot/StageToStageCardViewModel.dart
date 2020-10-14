import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/bloc/plot/StageBusinessLogic.dart';
import 'package:farmsmart_flutter/model/entities/StageEntity.dart';
import 'package:farmsmart_flutter/model/entities/PlotEntity.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/playground/styles/stage_card_styles.dart';
import 'package:intl/intl.dart';

class _LocalisedStrings {
  static stage() => Intl.message('Stage');

  static inProgress() => Intl.message('In Progress');

  static upcoming() => Intl.message('Upcoming');

  static complete() => Intl.message('Complete');

  static completeAction() => Intl.message('Completed');

  static revertAction() => Intl.message('Revert to In Progress');

  static readyAction() => Intl.message('Begin Stage');

  static upcomingAction() => Intl.message('Please complete previous');

  static inProgressAction() => Intl.message('Mark as complete');

  static beginCropDialogTitle() => Intl.message('Begin crop');

  static markAsCompleteDialogTitle() => Intl.message('Mark as complete');

  static completeCropTitle() => Intl.message('Complete crop');

  static revertDialogTitle() => Intl.message('Revert crop');

  static beginCropDialogDescription() =>
      Intl.message('Are you sure you want to mark this stage as in progress?');

  static markAsCompleteDialogDescription() =>
      Intl.message('Are you sure you want to mark this stage as complete?');

  static completeCropDialogDescription() =>
      Intl.message('Are you sure you want to market this crop as complete?');

  static revertDialogDescription() =>
      Intl.message('Are you sure you want revert the stage status?');
}

class StageToStageCardViewModel
    extends ObjectTransformer<StageEntity, StageCardViewModel> {
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
        _LocalisedStrings.stage() + " " + stageNumber.toString();
    final status = _logic.status(from);
    return StageCardViewModel(
      title: from.article.title,
      subtitle: subtitle,
      statusTitle: _statusTitle(status),
      actionText: _actionTitle(status, from),
      action: _action(status, from),
      style: _cardStyle(status, from),
      dialogTitle: _dialogTitle(status, from),
      dialogDescription: _dialogDescription(status, from),
    );
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
        return _LocalisedStrings.inProgressAction();
        break;
      case StageStatus.complete:
        return _logic.canRevert(stage, _plot.stages)
            ? _LocalisedStrings.revertAction()
            : _LocalisedStrings.completeAction();
        break;
      default:
        return _logic.canBegin(stage, _plot.stages)
            ? _LocalisedStrings.readyAction()
            : _LocalisedStrings.upcomingAction();
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
        return _LocalisedStrings.inProgress();
        break;
      case StageStatus.complete:
        return _LocalisedStrings.complete();
        break;
      default:
        return _LocalisedStrings.upcoming();
    }
  }

  String _dialogTitle(StageStatus status, StageEntity stage) {
    if (_logic.canBegin(stage, _plot.stages)) {
      return _LocalisedStrings.beginCropDialogTitle();
    } else if (_logic.canComplete(stage, _plot.stages)) {
      if (stage == _plot.stages.last) {
        return _LocalisedStrings.completeCropTitle();
      } else {
        return _LocalisedStrings.markAsCompleteDialogTitle();
      }
    } else if (_logic.canRevert(stage, _plot.stages)) {
      return _LocalisedStrings.revertDialogTitle();
    }
    return null;
  }

  String _dialogDescription(StageStatus status, StageEntity stage) {
    if (_logic.canBegin(stage, _plot.stages)) {
      return _LocalisedStrings.beginCropDialogDescription();
    } else if (_logic.canComplete(stage, _plot.stages)) {
      if (stage == _plot.stages.last) {
        return _LocalisedStrings.completeCropDialogDescription();
      } else {
        return _LocalisedStrings.markAsCompleteDialogDescription();
      }
    } else if (_logic.canRevert(stage, _plot.stages)) {
      return _LocalisedStrings.revertDialogDescription();
    }
    return null;
  }
}
