import 'package:flutter/material.dart';

class _Constants {
  static const defaultAssetImageSource = "assets/icons/chatbot_avatar.png";
}

class HeaderMessageStyle {
  final EdgeInsetsGeometry outerContainerMargin;
  final Color avatarBackgroundColour;
  final double avatarRadius;
  final EdgeInsetsGeometry titleMargins;
  final EdgeInsetsGeometry subtitleMargins;
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;

  const HeaderMessageStyle({
    this.outerContainerMargin,
    this.titleMargins,
    this.avatarRadius,
    this.avatarBackgroundColour,
    this.subtitleMargins,
    this.titleTextStyle,
    this.subtitleTextStyle,
  });

  HeaderMessageStyle copyWith({
    EdgeInsetsGeometry outerContainerMargin,
    Color avatarBackgroundColour,
    double avatarRadius,
    EdgeInsetsGeometry titleMargins,
    EdgeInsetsGeometry subtitleMargins,
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
  }) {
    return HeaderMessageStyle(
        outerContainerMargin: outerContainerMargin ?? this.outerContainerMargin,
        avatarBackgroundColour:
            avatarBackgroundColour ?? this.avatarBackgroundColour,
        avatarRadius: avatarRadius ?? this.avatarRadius,
        titleMargins: titleMargins ?? this.titleMargins,
        subtitleMargins: subtitleMargins ?? this.subtitleMargins,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle);
  }
}

class _DefaultStyle extends HeaderMessageStyle {
  final EdgeInsetsGeometry outerContainerMargin =
      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0);
  final Color avatarBackgroundColour = const Color(0xFF00CD9F);
  final double avatarRadius = 32.0;
  final EdgeInsetsGeometry titleMargins = const EdgeInsets.only(top: 23.0);
  final EdgeInsetsGeometry subtitleMargins = const EdgeInsets.only(top: 20.0);
  final TextStyle titleTextStyle = const TextStyle(
      fontSize: 27, fontWeight: FontWeight.bold, color: Color(0xFF1B1B34));
  final TextStyle subtitleTextStyle =
      const TextStyle(fontSize: 15, color: Color(0xFF4C4C6D));

  const _DefaultStyle({
    EdgeInsetsGeometry outerContainerMargin,
    Color avatarBackgroundColour,
    double avatarRadius,
    EdgeInsetsGeometry titleMargins,
    EdgeInsetsGeometry subtitleMargins,
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
  });
}

const HeaderMessageStyle _defaultStyle = const _DefaultStyle();

class HeaderMessage extends StatelessWidget {
  final HeaderMessageViewModel _viewModel;
  final HeaderMessageStyle _style;

  HeaderMessage({
    HeaderMessageViewModel viewModel,
    HeaderMessageStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _style.outerContainerMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAvatar(),
          _buildTitle(),
          _buildSubtitle(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      backgroundColor: _style.avatarBackgroundColour,
      backgroundImage: AssetImage(_viewModel?.backgroundAssetImageSource ?? ""),
      radius: _style.avatarRadius,
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: _style.titleMargins,
      child: Text(
        _viewModel.title,
        style: _style.titleTextStyle,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Container(
      margin: _style.subtitleMargins,
      child: Text(
        _viewModel.subtitle,
        style: _style.subtitleTextStyle,
      ),
    );
  }
}

class HeaderMessageViewModel {
  final String title;
  final String subtitle;
  final String backgroundAssetImageSource;

  HeaderMessageViewModel({
    this.title = "",
    this.subtitle = "",
    this.backgroundAssetImageSource = _Constants.defaultAssetImageSource,
  });
}
