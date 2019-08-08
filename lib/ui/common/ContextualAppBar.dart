import 'package:flutter/material.dart';

class _Icons {
  static final String dismissModal = "assets/raw/nav_icon_cancel.png";
}

class _Constants {
  static final double appBarIconSize = 24;
}

abstract class ContextualAppBarStyle {
  final double elevation;
  final Color iconColor;
  final EdgeInsets insets;

  ContextualAppBarStyle(this.elevation, this.iconColor, this.insets);
}

class _DefaultStyle implements ContextualAppBarStyle {
  final double elevation = 0;
  final Color iconColor = Colors.black;
  final EdgeInsets insets = const EdgeInsets.only(left: 25.0, right: 25.0);

  const _DefaultStyle();
}

const ContextualAppBarStyle _defaultStyle = const _DefaultStyle();

class ContextualAppBar extends StatelessWidget {
  final ContextualAppBarStyle _style;
  final _shareAction;
  final _moreAction;
  final bool _isModal;

  const ContextualAppBar({
    Key key,
    Function shareAction,
    ContextualAppBarStyle style = _defaultStyle,
    Function moreAction,
    bool isModal = false,
  })  : this._style = style,
        this._shareAction = shareAction,
        this._moreAction = moreAction,
        this._isModal = isModal,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRoot = !Navigator.of(context).canPop();
    final share = Container(
        margin: EdgeInsets.only(right: _style.insets.right),
        child: IconButton(
          icon: Icon(Icons.share, color: _style.iconColor),
          onPressed: _shareAction,
        ));
    final more = Container(
        margin: EdgeInsets.only(right: _style.insets.right),
        child: IconButton(
          icon: Icon(Icons.more_horiz, color: _style.iconColor),
          onPressed: _moreAction,
        ));
    List<Widget> actions = [];
    if (_shareAction != null) {
      actions.add(share);
    }
    if (_moreAction != null) {
      actions.add(more);
    }
    return AppBar(
      leading: isRoot ? _buildDismissIcon(context) : _buildBackIcon(context),
      backgroundColor: theme.primaryColor,
      elevation: _style.elevation,
      actions: actions,
    );
  }

  Widget _buildBackIcon(BuildContext context) {
    if (_isModal) {
      return _buildDismissIcon(context);
    } else {
      return Container(
        margin: EdgeInsets.only(left: _style.insets.left),
        child: BackButton(
          color: _style.iconColor,
        ),
      );
    }
  }

  Widget _buildDismissIcon(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: _style.insets.left),
      child: IconButton(
          icon: Icon(
            Icons.close,
            color: _style.iconColor,
            size: _Constants.appBarIconSize,
          ),
          onPressed: () => Navigator.of(context).pop()),
    );
  }
}
