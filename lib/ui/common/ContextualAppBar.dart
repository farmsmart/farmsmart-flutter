
import 'package:flutter/material.dart';

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

  const ContextualAppBar({Key key, Function shareAction, ContextualAppBarStyle style = _defaultStyle}) : this._style = style, this._shareAction = shareAction, super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRoot = ! Navigator.of(context).canPop();
    final share = Container(
      margin: EdgeInsets.only(right:_style.insets.right),
      child:IconButton(icon: Icon(Icons.share, color: _style.iconColor), onPressed: _shareAction,));
    final actions = (_shareAction == null) ? [] : [share]; 
    return AppBar(
      leading: isRoot ? _buildDismissIcon(context) : _buildBackIcon(),
      backgroundColor: theme.primaryColor,
      elevation: _style.elevation,
      actions: actions,
    );
  }

  Widget _buildBackIcon() {
    return Container(
      margin: EdgeInsets.only(left:_style.insets.left),
      child: BackButton(
          color: _style.iconColor,
      ),
    );
  }

  Widget _buildDismissIcon(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:_style.insets.left),
      child: IconButton(
        icon: Icon(Icons.close,
            color: _style.iconColor),
        onPressed: () => Navigator.of(context).pop()),
    );
  }

}