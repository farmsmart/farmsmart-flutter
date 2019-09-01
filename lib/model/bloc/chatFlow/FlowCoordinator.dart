import 'package:flutter/widgets.dart';

enum FlowCoordinatorStatus {
  Idle,
  InProgress,
  Complete
}

abstract class FlowCoordinator {
  void run(BuildContext context, {Function onSuccess, Function onFail});
  FlowCoordinatorStatus get status;
}