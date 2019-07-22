
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRoundedButtonViewModel.dart';
import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text("TEST"),
      onPressed: () => _confirmDialog(context),
    );
  }

  Future<bool> _confirmDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are u sure"),
          content: RoundedButton(viewModel: MockRoundedButtonViewModel.buildLarge(),
            style: RoundedButtonStyle.largeRoundedButtonStyle(),
          ),
        );
      }
    );
  }
}
