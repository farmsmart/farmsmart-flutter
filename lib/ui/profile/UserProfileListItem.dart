import 'package:flutter/material.dart';

class _Constants {
  String arrowIcon = "";
}

class UserProfileListItemViewModel {
  String icon;
  String title;
  Function onTa;
  bool isDestructive;

  UserProfileListItemViewModel({
    this.icon,
    this.title,
    this.onTa,
    this.isDestructive,
  });
}

class UserProfileListItemStyle {

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
    return Padding(
      padding: EdgeInsets.only(left: 32, right: 25),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10.8),
        dense: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  "assets/icons/radio_button_default.png",
                  height: 20,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Switch Language",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                ),
              ],
            ),
            Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }
}
