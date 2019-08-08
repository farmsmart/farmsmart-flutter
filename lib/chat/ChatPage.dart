import 'dart:io';

import 'package:farmsmart_flutter/chat/flow/implementation/ChatFlowFromFile.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/ChatResponseViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/ui/common/modal_navigator.dart';
import 'package:farmsmart_flutter/ui/profile/FarmDetails.dart';
import 'package:farmsmart_flutter/ui/profile/FarmDetailsListItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Constants {
  static final double appBarElevation = 0;
  static final EdgeInsets appBarEdgePadding = EdgeInsets.only(left: 25);
  static final double appBarIconSize = 16;
  static final EdgeInsets topButtonEdgePadding =
      const EdgeInsets.only(right: 32.0);
  static final EdgeInsets generalEdgePadding =
      const EdgeInsets.only(left: 32, top: 10, bottom: 36);
  static final EdgeInsets bottomButtonEdgePadding =
      const EdgeInsets.only(right: 24, left: 24, bottom: 24);
}

class _Assets {
  static const defaultPathToJSONFile =
      "assets/responses/create_account_mock_form.json";
  static const dismissModalIcon = "assets/raw/nav_icon_cancel.png";
  static const optionButtonIcon = "assets/icons/nav_icon_options.png";
}

class _LocalisedStrings {
  static resetProcess() => Intl.message("Reset Process");

  static skip() => Intl.message("Skip");

  static cancel() => Intl.message("Cancel");
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildSimpleAppBar(context),
      body: _buildChat(context),
    );
  }

  AppBar _buildSimpleAppBar(BuildContext context) {
    return AppBar(
      elevation: _Constants.appBarElevation,
      leading: _buildCloseButton(context),
      actions: <Widget>[_buildOptionsButton(context)],
    );
  }

  _buildChat(BuildContext context) => ChatFlowFromFile(context).start(
        file: _createChatFile(),
        onSuccess: (map) {
          _doOnSuccess(context, map);
        },
        onError: (error) {
          _doOnError(context, error);
        },
      );

  _buildCloseButton(BuildContext context) => FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        padding: _Constants.appBarEdgePadding,
        child: Image.asset(
          _Assets.dismissModalIcon,
          height: _Constants.appBarIconSize,
          width: _Constants.appBarIconSize,
        ),
      );

  _buildOptionsButton(BuildContext context) => Center(
        child: FlatButton(
          onPressed: () => _optionsTapped(
            _optionsMenu(context),
            context,
          ),
          child: Image.asset(
            _Assets.optionButtonIcon,
            width: _Constants.appBarIconSize,
            height: _Constants.appBarIconSize,
          ),
        ),
      );

  File _createChatFile() => File(_Assets.defaultPathToJSONFile);

  _doOnSuccess(BuildContext context, Map<String, ChatResponseViewModel> map) {
    print("On Success recevied: ${map.toString()}");
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => NavigationScope(
          child: FarmDetails(
        viewModel: FarmDetailsViewModel(
          items: _getFarmDetailsListFromMap(map),
          buttonTitle: "Confirm",
          confirm: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      )),
    );
  }

  List<FarmDetailsListItemViewModel> _getFarmDetailsListFromMap(
      Map<String, ChatResponseViewModel> map) {
    List<FarmDetailsListItemViewModel> viewModels = List();
    map.forEach((key, value) {
      viewModels.add(
        FarmDetailsListItemViewModel(
          title: key,
          detail: value.responseText,
        ),
      );
    });
    return viewModels;
  }

  _doOnError(BuildContext context, String error) {
    print("On Error recevied: ${error.toString()}");
    Navigator.of(context).pop();
  }

  void _optionsTapped(ActionSheet sheet, BuildContext context) {
    ActionSheet.present(sheet, context);
  }

  ActionSheet _optionsMenu(BuildContext context) {
    final actions = [
      ActionSheetListItemViewModel(
        title: _LocalisedStrings.resetProcess(),
        type: ActionType.selectable,
        onTap: () {},
      ),
      ActionSheetListItemViewModel(
        title: _LocalisedStrings.skip(),
        type: ActionType.selectable,
        onTap: () => Navigator.of(context).pop(),
      ),
    ];

    final actionSheetViewModel = ActionSheetViewModel(
      actions,
      _LocalisedStrings.cancel(),
    );
    return ActionSheet(
      viewModel: actionSheetViewModel,
      style: ActionSheetStyle.defaultStyle(),
    );
  }
}
