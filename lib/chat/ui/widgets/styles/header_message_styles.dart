import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/header_message.dart';

class _Constants {
  static const Color titleColor = Color(0xFF1A1B46);
  static const Color subtitleColor = Color(0xFF767690);
  static const Color avatarBackgroundColor = Color(0xFF24D900);
}

class HeaderMessageStyles {
  static HeaderMessageStyle buildDefaultStyle() => _defaultHeaderStyle;

  static const _defaultHeaderStyle = HeaderMessageStyle(
    outerContainerMargin: const EdgeInsets.all(0.0),
    titleTextStyle: const TextStyle(
      fontSize: 27.0,
      fontWeight: FontWeight.bold,
      color: _Constants.titleColor,
    ),
    titleMargins: const EdgeInsets.only(top: 20.0),
    subtitleTextStyle: const TextStyle(
      fontSize: 17,
      color: _Constants.subtitleColor,
    ),
    subtitleMargins: const EdgeInsets.only(top: 11.0),
    avatarRadius: 36.0,
    avatarBackgroundColour: _Constants.avatarBackgroundColor,
  );
}
