import 'package:farmsmart_flutter/ui/community/LinkBox.dart';
import 'package:flutter/material.dart';

class LinkBoxStyles {
  static LinkBoxStyle buildWhatsAppStyle() {
    return LinkBoxStyle(
      cardBackgroundColor: Color(0xfff5f8fa),
      imageContainerColor: Color(0xff25d366),
    );
  }

  static LinkBoxStyle buildBrowserStyle() {
    return LinkBoxStyle(
      iconColor: Color(0xff4c4e6e),
      cardBackgroundColor: Color(0xfff5f8fa),
      imageContainerColor: Color(0xffe9eaf2),
    );
  }
}
