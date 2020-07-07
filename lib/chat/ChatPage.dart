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
  static final dateFormatter = DateFormat('dd MMMM yyyy');
  static final double appBarElevation = 0;
  static final EdgeInsets appBarEdgePadding = EdgeInsets.only(left: 25);
  static final double appBarIconSize = 16;
}

class _Assets {
  static const dismissModalIcon = "assets/raw/nav_icon_cancel.png";
  static const optionButtonIcon = "assets/icons/nav_icon_options.png";
}

class _Errors {
  static const cancelled = "operation cancelled";
}

class _LocalisedStrings {
  static resetProcess() => Intl.message("Reset Process");

  static skip() => Intl.message("Skip");

  static cancel() => Intl.message("Cancel");

  static confirm() => Intl.message("Confirm Details");
}

class ChatPageViewModel {
    final String flowFilePath;
    final Function onSuccess;
    final Function onError;

  ChatPageViewModel(this.flowFilePath, this.onSuccess, this.onError);
}

class ChatPage extends StatefulWidget {
  final ChatPageViewModel _viewModel;
  const ChatPage({Key key, ChatPageViewModel viewModel}) : this._viewModel= viewModel, super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  _ChatPageState();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _cancel(context);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: _buildSimpleAppBar(context),
        body: _buildChat(context),
      ),
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
        onPressed: () => _cancel(context),
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

  File _createChatFile() {
      return File(widget._viewModel.flowFilePath);
  }

  _doOnSuccess(BuildContext context, Map<String, ChatResponseViewModel> map) {
    print("On Success recevied: ${map.toString()}");

    NavigationScope.presentModal(
      context,
      FarmDetails(
        viewModel: FarmDetailsViewModel(
          items: _getFarmDetailsListFromMap(map),
          buttonTitle: _LocalisedStrings.confirm(),
          confirm: () {
            _navigateBack(context);
            _navigateBack(context);
            widget._viewModel.onSuccess(map);
          },
        ),
      ),
    );
  }

  List<FarmDetailsListItemViewModel> _getFarmDetailsListFromMap(
      Map<String, ChatResponseViewModel> map) {
    List<FarmDetailsListItemViewModel> viewModels = List();
    map.forEach((key, value) {
      viewModels.add(
        FarmDetailsListItemViewModel(
          title: value.title,
          detail: _getDetail(value.value),
        ),
      );
    });
    return viewModels;
  }

  String _getDetail(dynamic value) => value is DateTime ? _formatDate(value) : value;

  String _formatDate(DateTime date) => _Constants.dateFormatter.format(date);
  
  _doOnError(BuildContext context, String error) {
    print("On Error recevied: ${error.toString()}");
    _navigateBack(context);
    widget._viewModel.onError(error);
  }

  void _optionsTapped(ActionSheet sheet, BuildContext context) =>
      ActionSheet.present(sheet, context);

  ActionSheet _optionsMenu(BuildContext context) {
    final actions = [
      ActionSheetListItemViewModel(
          title: _LocalisedStrings.resetProcess(),
          type: ActionType.simple,
          onTap: () {
            setState(() {});
          }),
      ActionSheetListItemViewModel(
        title: _LocalisedStrings.skip(),
        type: ActionType.simple,
        onTap: () => _cancel(context),
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

  void _cancel(BuildContext context) {
    _doOnError(context, _Errors.cancelled);
  }

  void _navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
