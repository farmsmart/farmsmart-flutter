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
  MessageBubbleViewModel getMessageFromEntity(FormItemEntity entity) =>
      _getMessageAsBubble(entity);

  @override
  MessageBubbleViewModel getHeaderMessage(FormEntity entity) =>
      _getMessageAsHeader(_getHeaderViewModel(entity));

  @override
  MessageBubbleViewModel getMessageFromString(String providedMessage) =>
      _getMessageAsBubbleFromProvided(providedMessage);

  @override
  MessageBubbleViewModel getLoadingMessage() => _getMessageAsLoading();

  HeaderMessageViewModel _getHeaderViewModel(FormEntity form) =>
      ChatHeaderViewModelTransformer().transform(from: form);

  MessageBubbleViewModel _getMessageAsHeader(
          HeaderMessageViewModel viewModel) =>
      MessageBubbleViewModel(
        messageChild: HeaderMessage(viewModel: viewModel),
        messageType: MessageType.header,
      );

  MessageBubbleViewModel _getMessageAsBubble(FormItemEntity entity) =>
      ChatMessageViewModelTransformer().transform(from: entity);

  MessageBubbleViewModel _getMessageAsBubbleFromProvided(
          String providedMessage) =>
      MessageBubbleViewModel(
        message: providedMessage,
        messageType: MessageType.sent,
      );

  MessageBubbleViewModel _getMessageAsLoading() => MessageBubbleViewModel(
        message: null,
        avatar: MessageCircleAvatar(
          messageCircleAvatarViewModel: MessageCircleAvatarViewModel(
              backgroundAssetImageSource: _Constants.defaultEmptyString),
        ),
        messageChild: FadingDots(),
        messageType: MessageType.loading,
      );
}
