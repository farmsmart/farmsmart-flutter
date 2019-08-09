import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/bloc/provider/ChatProvider.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/bubble_message.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/chat_list.dart';

class ChatStyle {
  final Color mainContainerColor;
  final CrossAxisAlignment crossAxisAlignment;

  const ChatStyle({
    this.mainContainerColor,
    this.crossAxisAlignment,
  });

  ChatStyle copyWith({
    Color mainContainerColor,
    CrossAxisAlignment crossAxisAlignment,
  }) {
    return ChatStyle(
      mainContainerColor: mainContainerColor ?? this.mainContainerColor,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
    );
  }
}

class _DefaultStyle extends ChatStyle {
  final Color mainContainerColor = const Color(0xFFFFFFFF);
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;

  const _DefaultStyle({
    Color mainContainerColor,
    CrossAxisAlignment crossAxisAlignment,
  });
}

const ChatStyle _defaultStyle = const _DefaultStyle();

class Chat extends StatelessWidget {
  final ChatProvider _chatProvider;
  final ChatStyle _style;

  bool _notNull(Widget item) => item != null;

  Chat({
    @required ChatProvider chatProvider,
    ChatStyle style = _defaultStyle,
  })  : this._chatProvider = chatProvider,
        this._style = style;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatViewModel>(
      initialData: _chatProvider.initial(),
      stream: _chatProvider.observe().stream,
      builder: (BuildContext context,
          AsyncSnapshot<ChatViewModel> chatProviderSnapshot) {
        return Container(
          color: _style.mainContainerColor,
          child: Column(
            crossAxisAlignment: _style.crossAxisAlignment,
            children: <Widget>[
              _buildList(chatProviderSnapshot.data),
              _buildInteractiveWidget(chatProviderSnapshot.data),
            ].where(_notNull).toList(),
          ),
        );
      },
    );
  }

  _buildList(ChatViewModel chatViewModel) {
    if (chatViewModel.messageViewModels != null) {
      return ChatList(
        messages: chatViewModel.messageViewModels,
        scrollController: chatViewModel.scrollController,
      );
    }
  }

  _buildInteractiveWidget(ChatViewModel chatViewModel) {
    return chatViewModel.interactiveWidget;
  }
}

class ChatViewModel {
  final List<MessageBubbleViewModel> messageViewModels;
  final ScrollController scrollController;
  Widget interactiveWidget;

  ChatViewModel({
    List<MessageBubbleViewModel> messageViewModels,
    Widget interactiveWidget,
    ScrollController scrollController,
  })  : this.messageViewModels = messageViewModels ?? [],
        this.interactiveWidget = interactiveWidget,
        this.scrollController = scrollController ?? ScrollController();
}
