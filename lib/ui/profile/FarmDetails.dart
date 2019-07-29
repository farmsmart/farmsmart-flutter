import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profile/FarmDetailsListItem.dart';
import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Strings {
  static final String yourName = Intl.message("Your Name");
  static final String country = Intl.message("Country");
  static final String landSize = Intl.message("Land Size");
  static final String season = Intl.message("Season");
  static final String motivation = Intl.message("Motivation");
  static final String soilType = Intl.message("Soil Type");
  static final String farmDetailsTitle = Intl.message("Your Farm Details");
}

class FarmDetailsViewModel {
  List<FarmDetailsListItemViewModel> items;
  final Function editProfile;
  final Function removeProfile;

  FarmDetailsViewModel({this.items, this.removeProfile, this.editProfile});
}

class FarmDetailsStyle {}

class FarmDetails extends StatelessWidget {
  final FarmDetailsViewModel _viewModel;
  final FarmDetailsStyle _style;

  const FarmDetails(
      {Key key, FarmDetailsViewModel viewModel, FarmDetailsStyle style})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, _viewModel),
      body: buildPage(context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(32),
        child: RoundedButton(
            viewModel: RoundedButtonViewModel(title: "Confirm Details"),
            style: RoundedButtonStyle.largeRoundedButtonStyle()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_buildHeader(), _buildList()],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              _Strings.farmDetailsTitle,
              style: TextStyle(
                color: Color(0xff1a1b46),
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      primary: false,
      itemBuilder: (context, index) =>
          FarmDetailsListItem(viewModel: _viewModel.items[index]),
      shrinkWrap: true,
      separatorBuilder: (context, index) => ListDivider.build(),
      itemCount: _viewModel.items.length,
    );
  }



  Widget _buildAppBar(BuildContext context, FarmDetailsViewModel viewModel) {
    return ContextualAppBar(
      moreAction: () => _moreTapped(_moreMenu(viewModel, context), context),
    ).build(context);
  }

  void _moreTapped(ActionSheet sheet, BuildContext context) {
    ActionSheet.present(sheet, context);
  }

  void _removeAction(FarmDetailsViewModel viewModel, BuildContext context) {
    viewModel.removeProfile();    //TODO: add the confirm when ready
    Navigator.of(context).pop();
  }

  void _editAction(FarmDetailsViewModel viewModel) {
    viewModel.editProfile();   //TODO: add the UI for input when ready
  }

  ActionSheet _moreMenu(FarmDetailsViewModel viewModel, BuildContext context) {
    final actions = [
      ActionSheetListItemViewModel(title: Intl.message("Edit profile"), type: ActionType.simple, onTap: () => _editAction(viewModel)),
      ActionSheetListItemViewModel(title: Intl.message("Delete profile"), type: ActionType.simple, isDestructive: true, onTap: () => _removeAction(viewModel, context)),
    ];
    final actionSheetViewModel = ActionSheetViewModel(actions, Intl.message("Cancel"));
    return ActionSheet(viewModel: actionSheetViewModel, style: ActionSheetStyle.defaultStyle());
  }
}
