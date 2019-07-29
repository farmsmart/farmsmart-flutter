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

class FarmDetailsListItemViewModel {
  String title;
  String detail;

  FarmDetailsListItemViewModel({this.title, this.detail});
}

class FarmDetailsListItemStyle {}

class FarmDetailsListItem extends StatelessWidget {
  final FarmDetailsListItemViewModel _viewModel;
  final FarmDetailsListItemStyle _style;

  const FarmDetailsListItem(
      {Key key, FarmDetailsListItemViewModel viewModel, FarmDetailsListItemStyle style})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 32),
      title: Text(_viewModel.title, style: TextStyle(
        color: Color(0xff1a1b46),
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),),
      trailing: Text(_viewModel.detail, style: TextStyle(
        color: Color(0xff767690),
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),),
    );
  }
}
