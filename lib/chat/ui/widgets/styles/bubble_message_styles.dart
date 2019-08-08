import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/bubble_message.dart';

class _Constants {
  static const receivedTextColor = const Color(0xFF1A1B46);
  static const receivedBackgroundColor = const Color(0xFFE9EAF2);
  static const sentTextColor = const Color(0xFFFFFFFF);
  static const sentBackgroundColor = const Color(0xFF24D900);
  static const defaultRadius = const Radius.circular(20.0);
  static const receivedStackMessageBorderRadius = const Radius.circular(5.0);

  static const messageAdditionalMargin = 48.0;
  static const spaceBetweenMessages = 24.0;
  static const receivedStackMessageMargin = 2.0;
}

class MessageBubbleStyles {
  static MessageBubbleStyle buildStyleSent() => _defaultMolecule;

  static MessageBubbleStyle buildStyleReceived() => _defaultMolecule.copyWith(
        textStyle: const TextStyle(
          color: _Constants.receivedTextColor,
          fontSize: 15.0,
        ),
        outerContainerMargin: EdgeInsets.only(
          right: _Constants.messageAdditionalMargin,
          top: _Constants.spaceBetweenMessages,
        ),
        textContainerBackgroundColor: _Constants.receivedBackgroundColor,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.start,
        textContainerBorderRadius:
            const BorderRadius.all(_Constants.defaultRadius),
      );

  static MessageBubbleStyle buildStyleReceivedStackTop() =>
      buildStyleReceived().copyWith(
        textContainerBorderRadius: BorderRadius.only(
          topLeft: _Constants.defaultRadius,
          topRight: _Constants.defaultRadius,
          bottomLeft: _Constants.receivedStackMessageBorderRadius,
          bottomRight: _Constants.defaultRadius,
        ),
        outerContainerMargin: EdgeInsets.only(
          bottom: _Constants.receivedStackMessageMargin,
          right: _Constants.messageAdditionalMargin,
          top: _Constants.spaceBetweenMessages,
        ),
      );

  static MessageBubbleStyle buildStyleReceivedStackBottom() =>
      buildStyleReceived().copyWith(
        textContainerBorderRadius: BorderRadius.only(
          topLeft: _Constants.receivedStackMessageBorderRadius,
          topRight: _Constants.defaultRadius,
          bottomLeft: _Constants.defaultRadius,
          bottomRight: _Constants.defaultRadius,
        ),
        outerContainerMargin: EdgeInsets.only(
          right: _Constants.messageAdditionalMargin,
          top: _Constants.receivedStackMessageMargin,
        ),
      );

  static MessageBubbleStyle buildStyleReceivedStackBetween() =>
      buildStyleReceived().copyWith(
        textContainerBorderRadius: BorderRadius.only(
          topLeft: _Constants.receivedStackMessageBorderRadius,
          topRight: _Constants.defaultRadius,
          bottomLeft: _Constants.receivedStackMessageBorderRadius,
          bottomRight: _Constants.defaultRadius,
        ),
        outerContainerMargin: EdgeInsets.only(
          bottom: _Constants.receivedStackMessageMargin,
          right: _Constants.messageAdditionalMargin,
          top: _Constants.receivedStackMessageMargin,
        ),
      );

  static MessageBubbleStyle buildStyleHeader() => _defaultMolecule.copyWith(
        textContainerBorderRadius: BorderRadius.all(Radius.circular(0)),
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.start,
        outerContainerMargin: EdgeInsets.only(
          bottom: 20.0,
        ),
        textContainerPadding: EdgeInsets.all(0),
        textContainerBackgroundColor: Colors.transparent,
      );

  static MessageBubbleStyle buildStyleLoading() => _defaultMolecule.copyWith(
        outerContainerMargin: EdgeInsets.only(
          top: _Constants.spaceBetweenMessages,
        ),
        textContainerBackgroundColor: _Constants.receivedBackgroundColor,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.start,
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
    outerContainerMargin: const EdgeInsets.only(
      left: _Constants.messageAdditionalMargin,
      top: _Constants.spaceBetweenMessages,
    ),
    textContainerMargin: const EdgeInsets.all(0.0),
    textContainerBackgroundColor: _Constants.sentBackgroundColor,
    textStyle: const TextStyle(
      color: _Constants.sentTextColor,
      fontSize: 15.0,
    ),
    textAlignment: TextAlign.start,
    textContainerBorderRadius: const BorderRadius.all(_Constants.defaultRadius),
  );
}
