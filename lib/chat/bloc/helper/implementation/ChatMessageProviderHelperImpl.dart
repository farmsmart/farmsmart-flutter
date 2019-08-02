import 'package:farmsmart_flutter/chat/bloc/transformer/implementation/ChatHeaderViewModelTransformer.dart';
import 'package:farmsmart_flutter/chat/bloc/transformer/implementation/ChatMessageViewModelTransformer.dart';
import 'package:farmsmart_flutter/chat/model/form/form_entity.dart';
import 'package:farmsmart_flutter/chat/model/form/form_item_entity.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/bubble_message.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/message_circle_avatar.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/fading_dots.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/header_message.dart';

import '../ChatMessageProviderHelper.dart';

class _Constants {
  static const defaultEmptyString = "";
}

class ChatMessageProviderHelperImpl
    implements ChatMessageProviderHelper<MessageBubbleViewModel> {
  @override
  MessageBubbleViewModel getMessageFromEntity(FormItemEntity entity) {
    return _getMessageAsBubble(entity);
  }

  @override
  MessageBubbleViewModel getHeaderMessage(FormEntity entity) {
    return _getMessageAsHeader(_getHeaderViewModel(entity));
  }

  @override
  MessageBubbleViewModel getMessageFromString(String providedMessage) {
    return _getMessageAsBubbleFromProvided(providedMessage);
  }

  @override
  MessageBubbleViewModel getLoadingMessage() {
    return _getMessageAsLoading();
  }

  HeaderMessageViewModel _getHeaderViewModel(FormEntity form) {
    return ChatHeaderViewModelTransformer().transform(from: form);
  }

  MessageBubbleViewModel _getMessageAsHeader(HeaderMessageViewModel viewModel) {
    return MessageBubbleViewModel(
      messageChild: HeaderMessage(viewModel: viewModel),
      messageType: MessageType.header,
    );
  }

  MessageBubbleViewModel _getMessageAsBubble(FormItemEntity entity) {
    return ChatMessageViewModelTransformer().transform(from: entity);
  }

  MessageBubbleViewModel _getMessageAsBubbleFromProvided(
      String providedMessage) {
    return MessageBubbleViewModel(
      message: providedMessage,
      messageType: MessageType.sent,
    );
  }

  MessageBubbleViewModel _getMessageAsLoading() {
    return MessageBubbleViewModel(
      message: null,
      avatar: MessageCircleAvatar(
        messageCircleAvatarViewModel: MessageCircleAvatarViewModel(
            backgroundAssetImageSource: _Constants.defaultEmptyString),
      ),
      messageChild: FadingDots(),
      messageType: MessageType.loading,
    );
  }
}
