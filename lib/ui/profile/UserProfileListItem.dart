import 'package:flutter/material.dart';

class UserProfileListItemViewModel {
  String icon;
  String title;
  Function onTa;
  String arrow;
  bool isDestructive;

  UserProfileListItemViewModel({
    this.icon,
    this.title,
    this.onTa,
    this.arrow,
    this.isDestructive,
  });
}

class UserProfileListItem extends StatelessWidget {
  final UserProfileListItemViewModel _viewModel;

  const UserProfileListItem({
    Key key,
    UserProfileListItemViewModel viewModel,
  })  : this._viewModel = viewModel,
        super(key: key);



  @override
  Widget build(BuildContext context) {
    return Text("sdsdf");
  }
}
