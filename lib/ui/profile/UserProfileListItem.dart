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

class UserProfileListItemStyle {
  final TextStyle titleTextStyle;
  final TextStyle destructiveTextStyle;

  final EdgeInsets edgePadding;
  final EdgeInsets simpleEdgePadding;

  final double leadingWidth;
  final double leadingIconHeight;
  final double trailingWidth;
  final double trailingIconHeight;

  const UserProfileListItemStyle({
    this.titleTextStyle,
    this.destructiveTextStyle,
    this.edgePadding,
    this.simpleEdgePadding,
    this.leadingWidth,
    this.leadingIconHeight,
    this.trailingWidth,
    this.trailingIconHeight,
  });

  UserProfileListItemStyle copyWith({
    TextStyle titleTextStyle,
    TextStyle destructiveTextStyle,
    EdgeInsets edgePadding,
    EdgeInsets simpleEdgePadding,
    double leadingWidth,
    double leadingIconHeight,
    double trailingWidth,
    double trailingIconHeight,
  }) {
    return UserProfileListItemStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      destructiveTextStyle: destructiveTextStyle ?? this.destructiveTextStyle,
      edgePadding: edgePadding ?? this.edgePadding,
      simpleEdgePadding: simpleEdgePadding ?? this.simpleEdgePadding,
      leadingWidth: leadingWidth ?? this.leadingWidth,
      leadingIconHeight: leadingIconHeight ?? this.leadingIconHeight,
      trailingWidth: trailingWidth ?? this.trailingWidth,
      trailingIconHeight: trailingIconHeight ?? this.trailingIconHeight,
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

  final EdgeInsets edgePadding = const EdgeInsets.only(
    top: 10.8,
    bottom: 10.8,
    left: 12.5,
    right: 31.5,
  );

  final EdgeInsets simpleEdgePadding = const EdgeInsets.only(
    top: 10.8,
    bottom: 10.8,
    left: 33.5,
    right: 31.5,
  );

  final double leadingWidth = 41;
  final double leadingIconHeight = 20;
  final double trailingWidth = 7.5;
  final double trailingIconHeight = 13;

  const _DefaultStyle({
    TextStyle titleTextStyle,
    TextStyle destructiveTextStyle,
    EdgeInsets edgePadding,
    EdgeInsets simpleEdgePadding,
    double leadingWidth,
    double leadingIconHeight,
    double trailingWidth,
    double trailingIconHeight,
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
          ? _style.edgePadding
          : _style.simpleEdgePadding,
      dense: true,
      leading: _viewModel.icon != null
          ? Container(
              alignment: Alignment.centerRight,
              width: _style.leadingWidth,
              child: Image.asset(
                _viewModel.icon,
                height: _style.leadingIconHeight,
              ),
            )
          : null,
      trailing: Container(
        width: _style.trailingWidth,
        child: Image.asset(
          _Constants.arrowIcon,
          height: _style.trailingIconHeight,
        ),
      ),
      title: Text(
        _viewModel.title,
        style: !_viewModel.isDestructive
            ? _style.titleTextStyle
            : _style.destructiveTextStyle,
      ),
    );
  }
}
