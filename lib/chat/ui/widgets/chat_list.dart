import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/bubble_message.dart';

import 'styles/bubble_message_styles.dart';

class ChatListStyle {
  final bool shrinkWrap;
  final bool reverse;

  const ChatListStyle({
    this.shrinkWrap,
    this.reverse,
  });

  ChatListStyle copyWith({
    bool shrinkWrap,
    bool reverse,
  }) {
    return ChatListStyle(
      shrinkWrap: shrinkWrap ?? this.shrinkWrap,
      reverse: reverse ?? this.reverse,
    );
  }
}

class _DefaultStyle extends ChatListStyle {
  final bool shrinkWrap = true;
  final bool reverse = true;

  const _DefaultStyle({
    bool shrinkWrap,
    bool reverse,
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
      child: Container(
        child: ListView.builder(
            controller: _scrollController,
            shrinkWrap: _style.shrinkWrap,
            itemCount: _messages.length,
            reverse: _style.reverse,
            itemBuilder: (BuildContext context, int index) {
              return _buildMessage(index);
            }),
      ),
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
