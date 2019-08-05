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

class ProfileListItemViewModel {
  String icon;
  String title;
  Function onTap;
  bool isDestructive;

  ProfileListItemViewModel({
    this.icon,
    this.title,
    this.onTap,
    this.isDestructive,
  });
}

class ProfileListItemStyle {
  final TextStyle titleTextStyle;
  final TextStyle destructiveTextStyle;

  final int maxLines;

  const ProfileListItemStyle({
    this.titleTextStyle,
    this.destructiveTextStyle,
    this.maxLines,
  });

  ProfileListItemStyle copyWith({
    TextStyle titleTextStyle,
    TextStyle destructiveTextStyle,
    int maxLines,
  }) {
    return ProfileListItemStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      destructiveTextStyle: destructiveTextStyle ?? this.destructiveTextStyle,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}

class _DefaultStyle extends ProfileListItemStyle {
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

const ProfileListItemStyle _defaultStyle = const _DefaultStyle();

class ProfileListItem extends StatelessWidget {
  final ProfileListItemViewModel _viewModel;
  final ProfileListItemStyle _style;

  const ProfileListItem({
    Key key,
    ProfileListItemViewModel viewModel,
    ProfileListItemStyle style = _defaultStyle,
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
      leading: _buildLeading(),
      trailing: _buildTrailing(),
      title: _buildTitle(),
    );
  }

  Widget _buildLeading() {
    return _viewModel.icon != null
        ? Container(
            alignment: Alignment.centerRight,
            width: _Constants.leadingWidth,
            child: Image.asset(
              _viewModel.icon,
              height: _Constants.leadingIconHeight,
            ),
          )
        : null;
  }

  Widget _buildTrailing() {
    return Container(
      width: _Constants.trailingWidth,
      child: Image.asset(
        _Constants.arrowIcon,
        height: _Constants.trailingIconHeight,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      _viewModel.title,
      style: !_viewModel.isDestructive
          ? _style.titleTextStyle
          : _style.destructiveTextStyle,
      maxLines: _style.maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
