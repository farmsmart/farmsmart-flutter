import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/bubble_message.dart';

class _Constants {
  static const colorBlack = const Color(0xFF1B1B34);
  static const colorWhiteAccented = const Color(0xFFF5F5FA);
  static const colorGreen = const Color(0xFF00CD9F);
  static const colorWhite = const Color(0xFFFFFFFF);
}

class MessageBubbleStyles {
  static MessageBubbleStyle buildStyleSent() => _defaultMolecule;

  static MessageBubbleStyle buildStyleReceived() => _defaultMolecule.copyWith(
        textStyle:
            const TextStyle(color: _Constants.colorBlack, fontSize: 15.0),
        textContainerBackgroundColor: _Constants.colorWhiteAccented,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.start,
        textContainerMargin: const EdgeInsets.only(left: 12.0, right: 40.0),
      );

  static MessageBubbleStyle buildStyleHeader() => _defaultMolecule.copyWith(
        textContainerBorderRadius: BorderRadius.all(Radius.circular(0)),
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.start,
        outerContainerMargin: EdgeInsets.only(bottom: 70),
        textContainerMargin: EdgeInsets.all(0),
        textContainerPadding: EdgeInsets.all(0),
        textContainerBackgroundColor: Colors.transparent,
      );

  static MessageBubbleStyle buildStyleLoading() => _defaultMolecule.copyWith(
        textContainerBackgroundColor: _Constants.colorWhiteAccented,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.start,
        textContainerMargin: const EdgeInsets.only(
          left: 12.0,
          right: 40.0,
        ),
        textContainerPadding: const EdgeInsets.all(12.0),
      );

  static const _defaultMolecule = MessageBubbleStyle(
    rowMainAxisAlignment: MainAxisAlignment.end,
    rowCrossAxisAlignment: CrossAxisAlignment.end,
    textContainerPadding: const EdgeInsets.all(16.0),
    outerContainerMargin:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    textContainerMargin: const EdgeInsets.only(left: 30.0, right: 0.0),
    textContainerBackgroundColor: _Constants.colorGreen,
    textStyle: const TextStyle(color: _Constants.colorWhite, fontSize: 15.0),
    textAlignment: TextAlign.start,
    textContainerBorderRadius: const BorderRadius.all(Radius.circular(20.0)),
  );
}
