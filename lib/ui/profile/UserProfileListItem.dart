import 'package:flutter/material.dart';

class _Constants {
  static final String arrowIcon = "assets/icons/chevron.png";
}

class UserProfileListItemViewModel {
  String icon;
  String title;
  Function onTap;
  bool isDestructive;

  UserProfileListItemViewModel({
    this.icon,
    this.title,
    this.onTap,
    this.isDestructive,
  });
}

class UserProfileListItemStyle {}

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
        onTap: _viewModel.onTap,
        contentPadding: EdgeInsets.symmetric(vertical: 10.8),
        dense: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _viewModel.icon != null
                    ? Row(
                        children: <Widget>[
                          Image.asset(
                            _viewModel.icon,
                            height: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    : SizedBox(
                        width: 0,
                      ),
                Text(
                  _viewModel.title,
                  style: !_viewModel.isDestructive
                      ? TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        )
                      : TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color(0xffff6060),
                          fontSize: 17,
                        ),
                ),
              ],
            ),
            Image.asset(
              _Constants.arrowIcon,
              height: 13,
            ),
          ],
        ),
      ),
    );
  }
}
