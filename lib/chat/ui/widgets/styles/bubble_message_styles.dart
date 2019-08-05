import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/bubble_message.dart';

class _Constants {
  static const receivedTextColor = const Color(0xFF1A1B46);
  static const receivedBackgroundColor = const Color(0xFFE9EAF2);
  static const sentTextColor = const Color(0xFFFFFFFF);
  static const sentBackgroundColor = const Color(0xFF24D900);
  static const defaultRadius = Radius.circular(20.0);
}

class MessageBubbleStyles {
  static MessageBubbleStyle buildStyleSent() => _defaultMolecule;

  static MessageBubbleStyle buildStyleReceived() => _defaultMolecule.copyWith(
        textStyle: const TextStyle(
          color: _Constants.receivedTextColor,
          fontSize: 15.0,
        ),
        textContainerBackgroundColor: _Constants.receivedBackgroundColor,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.start,
        textContainerMargin: const EdgeInsets.only(
          left: 12.0,
          right: 40.0,
        ),
        textContainerBorderRadius:
            const BorderRadius.all(_Constants.defaultRadius),
      );

  static MessageBubbleStyle buildStyleReceivedStackTop() =>
      buildStyleReceived().copyWith(
        textContainerBorderRadius: BorderRadius.only(
          topLeft: _Constants.defaultRadius,
          topRight: _Constants.defaultRadius,
          bottomLeft: Radius.circular(5.0),
          bottomRight: _Constants.defaultRadius,
        ),
        outerContainerMargin: EdgeInsets.only(
          bottom: 4.0,
          right: 20.0,
          left: 20.0,
          top: 24.0,
        ),
      );

  static MessageBubbleStyle buildStyleReceivedStackBottom() =>
      buildStyleReceived().copyWith(
        textContainerBorderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: _Constants.defaultRadius,
          bottomLeft: _Constants.defaultRadius,
          bottomRight: _Constants.defaultRadius,
        ),
        outerContainerMargin: EdgeInsets.only(
          bottom: 20.0,
          right: 20.0,
          left: 20.0,
          top: 4.0,
        ),
      );

  static MessageBubbleStyle buildStyleReceivedStackBetween() =>
      buildStyleReceived().copyWith(
        textContainerBorderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: _Constants.defaultRadius,
          bottomLeft: Radius.circular(5.0),
          bottomRight: _Constants.defaultRadius,
        ),
        outerContainerMargin: EdgeInsets.only(
          bottom: 4.0,
          right: 20.0,
          left: 20.0,
          top: 4.0,
        ),
      );

  static MessageBubbleStyle buildStyleHeader() => _defaultMolecule.copyWith(
        textContainerBorderRadius: BorderRadius.all(Radius.circular(0)),
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.start,
        outerContainerMargin: EdgeInsets.only(bottom: 40),
        textContainerMargin: EdgeInsets.all(0),
        textContainerPadding: EdgeInsets.all(0),
        textContainerBackgroundColor: Colors.transparent,
      );

  static MessageBubbleStyle buildStyleLoading() => _defaultMolecule.copyWith(
        textContainerBackgroundColor: _Constants.receivedBackgroundColor,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.start,
        textContainerMargin: const EdgeInsets.only(
          left: 12.0,
          right: 40.0,
        ),
        textContainerPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 17.0,
        ),
      );

  static const _defaultMolecule = MessageBubbleStyle(
    rowMainAxisAlignment: MainAxisAlignment.end,
    rowCrossAxisAlignment: CrossAxisAlignment.end,
    textContainerPadding: const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 14.0,
    ),
    outerContainerMargin: const EdgeInsets.symmetric(
      vertical: 24.0,
      horizontal: 20.0,
    ),
    textContainerMargin: const EdgeInsets.only(
      left: 30.0,
      right: 0.0,
    ),
    textContainerBackgroundColor: _Constants.sentBackgroundColor,
    textStyle: const TextStyle(
      color: _Constants.sentTextColor,
      fontSize: 15.0,
    ),
    textAlignment: TextAlign.start,
    textContainerBorderRadius: const BorderRadius.all(_Constants.defaultRadius),
  );
}
