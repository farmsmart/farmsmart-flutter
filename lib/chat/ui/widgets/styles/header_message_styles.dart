import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/header_message.dart';

class _Constants {
  static const defaultOuterContainerMargin = const EdgeInsets.all(0.0);
  static const defaultTitleTextStyle = const TextStyle(
    fontSize: 27.0,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF1A1B46),
  );
  static const defaultTitleMargins = const EdgeInsets.only(top: 20.0);
  static const defaultSubtitleTextStyle = const TextStyle(
    fontSize: 17,
    color: const Color(0xFF767690),
  );
  static const defaultSubtitleMargins = const EdgeInsets.only(top: 11.0);
  static const defaultAvatarRadius = 36.0;
  static const defaultAvatarBackgroundColour = Color(0xFF24D900);
}

class HeaderMessageStyles {
  static HeaderMessageStyle buildDefaultStyle() => _defaultHeaderStyle;

  static const _defaultHeaderStyle = HeaderMessageStyle(
    outerContainerMargin: _Constants.defaultOuterContainerMargin,
    titleTextStyle: _Constants.defaultTitleTextStyle,
    titleMargins: _Constants.defaultTitleMargins,
    subtitleTextStyle: _Constants.defaultSubtitleTextStyle,
    subtitleMargins: _Constants.defaultSubtitleMargins,
    avatarRadius: _Constants.defaultAvatarRadius,
    avatarBackgroundColour: _Constants.defaultAvatarBackgroundColour,
  );
}
