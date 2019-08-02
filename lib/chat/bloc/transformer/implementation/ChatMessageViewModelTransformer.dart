import 'package:farmsmart_flutter/chat/model/form/form_item_entity.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/bubble_message.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/message_circle_avatar.dart';

import 'package:farmsmart_flutter/chat/bloc/transformer/Transformer.dart';

class _Constants {
  static const defaultAssetImageSource = "";
}

class ChatMessageViewModelTransformer
    implements ObjectTransformer<FormItemEntity, MessageBubbleViewModel> {
  @override
  MessageBubbleViewModel transform({FormItemEntity from}) {
    return MessageBubbleViewModel(
      message: from.text,
      messageType: MessageType.received,
      avatar: MessageCircleAvatar(
        messageCircleAvatarViewModel: MessageCircleAvatarViewModel(
          backgroundAssetImageSource: _Constants.defaultAssetImageSource,
        ),
      ),
    );
  }
}
