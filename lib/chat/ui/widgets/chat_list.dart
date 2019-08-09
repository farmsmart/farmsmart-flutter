import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/bubble_message.dart';

import 'styles/bubble_message_styles.dart';

class _Constants {
  static const defaultPadding = 32.0;
}

class ChatListStyle {
  final bool shrinkWrap;
  final bool reverse;
  final EdgeInsetsGeometry listPadding;

  const ChatListStyle({
    this.shrinkWrap,
    this.reverse,
    this.listPadding,
  });

  ChatListStyle copyWith({
    bool shrinkWrap,
    bool reverse,
    EdgeInsetsGeometry outerContainerMargins,
  }) {
    return ChatListStyle(
      shrinkWrap: shrinkWrap ?? this.shrinkWrap,
      reverse: reverse ?? this.reverse,
      listPadding: outerContainerMargins ?? this.listPadding,
    );
  }
}

class _DefaultStyle extends ChatListStyle {
  final bool shrinkWrap = true;
  final bool reverse = true;
  final EdgeInsetsGeometry listPadding =
      const EdgeInsets.all(_Constants.defaultPadding);

  const _DefaultStyle({
    bool shrinkWrap,
    bool reverse,
    EdgeInsetsGeometry outerContainerMargins,
  });
}

const ChatListStyle _defaultStyle = const _DefaultStyle();

class ChatList extends StatelessWidget {
  final ChatListStyle _style;
  final ScrollController _scrollController;
  final Function _onTapMessage;
  final List<MessageBubbleViewModel> _messages;

  ChatList({
    ChatListStyle style = _defaultStyle,
    Function onTapMessage,
    @required List<MessageBubbleViewModel> messages,
    @required ScrollController scrollController,
  })  : this._style = style,
        this._onTapMessage = onTapMessage ?? (() => {}),
        this._messages = messages,
        this._scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: _style.shrinkWrap,
          itemCount: _messages.length,
          reverse: _style.reverse,
          padding: _style.listPadding,
          itemBuilder: (BuildContext context, int index) {
            return _buildMessage(index);
          }),
    );
  }

  _buildMessage(int index) {
    if (_messages.isNotEmpty) {
      MessageBubbleViewModel message = _messages[index];
      return MessageBubble(
        viewModel: message,
        style: _getStyleByMessageType(message),
        onTap: _onTapMessage,
      );
    }
  }

  _getStyleByMessageType(MessageBubbleViewModel message) {
    switch (message.messageType) {
      case MessageType.sent:
        return MessageBubbleStyles.buildStyleSent();
      case MessageType.header:
        return MessageBubbleStyles.buildStyleHeader();
      case MessageType.loading:
        return MessageBubbleStyles.buildStyleLoading();
      case MessageType.received:
        return MessageBubbleStyles.buildStyleReceived();
      case MessageType.receivedStackTop:
        return MessageBubbleStyles.buildStyleReceivedStackTop();
      case MessageType.receivedStackBottom:
        return MessageBubbleStyles.buildStyleReceivedStackBottom();
      case MessageType.receivedStackBetween:
        return MessageBubbleStyles.buildStyleReceivedStackBetween();
      default:
        return MessageBubbleStyles.buildStyleSent();
    }
  }
}
