import 'package:farmsmart_flutter/ui/community/LinkBox.dart';
import 'package:flutter/material.dart';

class _Images {
  static final String whatsAppImage = "assets/icons/WhatsApp_Logo_short.png";
}

class MockLinkBoxViewModel {
  static LinkBoxViewModel buildWithImage() {
    return LinkBoxViewModel(
      titleText: "Farming Tech",
      detailText: "Join the WhatsApp group and discuss with fellow farmers",
      image: _Images.whatsAppImage,
      onTap: () => _mockAction(),
    );
  }

  static LinkBoxViewModel buildWithIcon() {
    return LinkBoxViewModel(
      titleText: "Farming Tech",
      detailText: "Join the WhatsApp group and discuss with fellow farmers",
      icon: Icons.open_in_browser,
      onTap: () => _mockAction(),
    );
  }

  static _mockAction() {
    print("This should redirect to whatsApp group");
  }
}
