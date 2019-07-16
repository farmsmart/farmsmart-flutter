import 'package:farmsmart_flutter/data/bloc/Transformer.dart';
import 'package:farmsmart_flutter/data/bloc/plot/StageBusinessLogic.dart';
import 'package:farmsmart_flutter/data/model/NewStageEntity.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/playground/styles/stage_card_styles.dart';
import 'package:intl/intl.dart';

class _Strings {
  static final stage = "Stage";

  static final inProgress = "In Progress";
  static final upcoming = "Upcoming";
  static final complete = "Complete";

  static final completeAction = "Revert to In Progress";
  static final upcomingAction = "Begin Stage";
  static final inProgressAction = "Mark as complete";
}

class StageToStageCardViewModel
    implements ObjectTransformer<NewStageEntity, StageCardViewModel> {
  final List<NewStageEntity> _allStages;
  final StageBusinessLogic _logic = StageBusinessLogic();

  StageToStageCardViewModel(this._allStages);

  @override
  StageCardViewModel transform({NewStageEntity from}) {
    final subtitle = Intl.message(_Strings.stage) +
        " " +
        _allStages.indexOf(from).toString();
        final status = _logic.status(from);
    return StageCardViewModel(
        title: from.article.title,
        subtitle: subtitle,
        statusTitle: _statusTitle(status),
        actionText: _actionTitle(status), 
        style: _cardStyle(status));
  }

  StageCardStyle _cardStyle(StageStatus status) {
    switch (status) {
      case StageStatus.inProgress:
        return StageCardStyles.buildInProgressStageStyle();
        break;
      case StageStatus.complete:
        return StageCardStyles.buildCompleteStageStyle();
        break;
      default:
        return StageCardStyles.builtUpcomingStageStyle();
    }
  }

  String _actionTitle(StageStatus status) {
    switch (status) {
      case StageStatus.inProgress:
        return Intl.message(_Strings.inProgressAction);
        break;
      case StageStatus.complete:
        return Intl.message(_Strings.completeAction);
        break;
      default:
        return Intl.message(_Strings.upcomingAction);
    }
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
