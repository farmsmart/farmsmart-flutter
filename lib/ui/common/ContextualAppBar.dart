import 'package:flutter/material.dart';

class _Icons {
  static final String dismissModal = "assets/icons/nav_icon_cancel.png";
  static final String backIcon = "assets/icons/nav_icon_back.png";
}

class _Constants {
  static final double appBarBackIconSize = 20;
  static final double appBarDismissIconSize = 15;
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
  final EdgeInsets insets = const EdgeInsets.only(left: 3.0, right: 25.0);

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
      backgroundColor: theme.primaryColor,
      elevation: _style.elevation,
      actions: actions,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          isRoot ? _buildDismissIcon(context) : _buildBackIcon(context),
        ],
      ),

    );
  }

  Widget _buildBackIcon(BuildContext context) {
    if (_isModal) {
      return _buildDismissIcon(context);
    } else {
      return Container(
        padding: EdgeInsets.only(left: _style.insets.left),
        child: IconButton(
          icon: Image.asset(
            _Icons.backIcon,
            width: _Constants.appBarBackIconSize,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      );
    }
  }

  Widget _buildDismissIcon(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: _style.insets.left),
      child: IconButton(
        icon: Image.asset(
          _Icons.dismissModal,
          width: _Constants.appBarDismissIconSize,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
