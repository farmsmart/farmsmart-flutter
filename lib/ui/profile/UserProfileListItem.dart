import 'package:flutter/material.dart';

class _Constants {
  static final String arrowIcon = "assets/icons/chevron.png";

  static final EdgeInsets edgePadding = const EdgeInsets.only(
    top: 10.8,
    bottom: 10.8,
    left: 12.5,
    right: 31.5,
  );

  static final EdgeInsets simpleEdgePadding = const EdgeInsets.only(
    top: 10.8,
    bottom: 10.8,
    left: 33.5,
    right: 31.5,
  );

  static final double leadingWidth = 41;
  static final double leadingIconHeight = 20;
  static final double trailingWidth = 7.5;
  static final double trailingIconHeight = 13;
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

class UserProfileListItemStyle {
  final TextStyle titleTextStyle;
  final TextStyle destructiveTextStyle;

  final int maxLines;

  const UserProfileListItemStyle({
    this.titleTextStyle,
    this.destructiveTextStyle,
    this.maxLines,
  });

  UserProfileListItemStyle copyWith({
    TextStyle titleTextStyle,
    TextStyle destructiveTextStyle,
    int maxLines,
  }) {
    return UserProfileListItemStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      destructiveTextStyle: destructiveTextStyle ?? this.destructiveTextStyle,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}

class _DefaultStyle extends UserProfileListItemStyle {
  final TextStyle titleTextStyle = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 17,
  );

  final TextStyle destructiveTextStyle = const TextStyle(
    fontWeight: FontWeight.normal,
    color: Color(0xffff6060),
    fontSize: 17,
  );

  final int maxLines = 1;

  const _DefaultStyle({
    TextStyle titleTextStyle,
    TextStyle destructiveTextStyle,
    int maxLines,
  });
}

const UserProfileListItemStyle _defaultStyle = const _DefaultStyle();

class UserProfileListItem extends StatelessWidget {
  final UserProfileListItemViewModel _viewModel;
  final UserProfileListItemStyle _style;

  const UserProfileListItem({
    Key key,
    UserProfileListItemViewModel viewModel,
    UserProfileListItemStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _viewModel.onTap(),
      contentPadding: _viewModel.icon != null
          ? _Constants.edgePadding
          : _Constants.simpleEdgePadding,
      dense: true,
      leading: _viewModel.icon != null
          ? Container(
              alignment: Alignment.centerRight,
              width: _Constants.leadingWidth,
              child: Image.asset(
                _viewModel.icon,
                height: _Constants.leadingIconHeight,
              ),
            )
          : null,
      trailing: Container(
        width: _Constants.trailingWidth,
        child: Image.asset(
          _Constants.arrowIcon,
          height: _Constants.trailingIconHeight,
        ),
      ),
      title: Text(
        _viewModel.title,
        style: !_viewModel.isDestructive
            ? _style.titleTextStyle
            : _style.destructiveTextStyle,
        maxLines: _style.maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
