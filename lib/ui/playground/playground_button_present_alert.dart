import 'package:farmsmart_flutter/ui/common/Alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaygroundButtonPresentAlertViewModel {
  Function(Alert, BuildContext) listener;
  Alert alert;

  PlaygroundButtonPresentAlertViewModel({this.listener, this.alert});
}

class PlaygroundButtonPresentAlert extends StatelessWidget {
  final PlaygroundButtonPresentAlertViewModel _viewModel;

  const PlaygroundButtonPresentAlert(
      {Key key, PlaygroundButtonPresentAlertViewModel viewModel, Widget child})
      : this._viewModel = viewModel,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text("Press to Show Alert"),
        onPressed: () => _viewModel.listener(_viewModel.alert, context),
      ),
    );
  }
}
