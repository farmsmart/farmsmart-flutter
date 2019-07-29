import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Strings {
  static final String YOUR_NAME = Intl.message("Your Name");
  static final String COUNTRY = Intl.message("Country");
  static final String LAND_SIZE = Intl.message("Land Size");
  static final String SEASON = Intl.message("Season");
  static final String MOTIVATION = Intl.message("Motivation");
  static final String SOIL_TYPE = Intl.message("Soil Type");

}

class FarmDetailsViewModel {
  String userName;
  String country;
  String landSize;
  String season;
  String motivation;
  String soilType;
  String irrigation;
  String buttonTitle;

  FarmDetailsViewModel({
    this.userName,
    this.country,
    this.landSize,
    this.season,
    this.motivation,
    this.soilType,
    this.irrigation,
    this.buttonTitle,
  });
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
        child: RoundedButton(viewModel: RoundedButtonViewModel(title: "Confirm Details"), style: RoundedButtonStyle.largeRoundedButtonStyle()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text("ds"),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
        "Your Farm Details"
    );
  }

  Widget _buildList() {

  }
}
