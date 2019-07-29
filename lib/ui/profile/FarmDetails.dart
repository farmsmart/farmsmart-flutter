import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profile/FarmDetailsListItem.dart';
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

  FarmDetailsViewModel({this.items});
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
      //appBar: ,
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
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 38),
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
}
