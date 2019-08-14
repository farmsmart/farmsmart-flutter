import 'package:farmsmart_flutter/chat/bloc/transformer/implementation/ChatHeaderViewModelTransformer.dart';
import 'package:farmsmart_flutter/chat/bloc/transformer/implementation/ChatMessageViewModelTransformer.dart';
import 'package:farmsmart_flutter/chat/model/form/form_entity.dart';
import 'package:farmsmart_flutter/chat/model/form/form_item_entity.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/ChatResponseViewModel.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/bubble_message.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/fading_dots.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/header_message.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/fading_dots_styles.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/header_message_styles.dart';

import '../ChatMessageViewModelHandler.dart';

class _Constants {
  static const percentDelimiter = "%";
}

class ChatMessageViewModelHandlerImpl
    implements ChatMessageViewModelHandler<MessageBubbleViewModel> {
  @override
  MessageBubbleViewModel getMessageFromEntity(FormItemEntity entity,
          Map<String, ChatResponseViewModel> responses) =>
      _getMessageAsBubble(entity, responses);

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
        messageChild: HeaderMessage(
          viewModel: viewModel,
          style: HeaderMessageStyles.buildDefaultStyle(),
        ),
        messageType: MessageType.header,
      );

  MessageBubbleViewModel _getMessageAsBubble(
      FormItemEntity entity, Map<String, ChatResponseViewModel> responses) {
    MessageBubbleViewModel viewModel =
        ChatMessageViewModelTransformer().transform(from: entity);
    return _getUpdateMessageByProvidedResponses(
      viewModel: viewModel,
      responses: responses,
    );
  }

  MessageBubbleViewModel _getMessageAsBubbleFromProvided(
          String providedMessage) =>
      MessageBubbleViewModel(
        message: providedMessage,
        messageType: MessageType.sent,
      );

  MessageBubbleViewModel _getMessageAsLoading() => MessageBubbleViewModel(
        messageChild: FadingDots(
          style: FadingDotsStyles.buildDefaultStyle(),
        ),
        messageType: MessageType.loading,
      );

  MessageBubbleViewModel _getUpdateMessageByProvidedResponses({
    MessageBubbleViewModel viewModel,
    Map<String, ChatResponseViewModel> responses,
  }) {
    if (viewModel.message.contains(_Constants.percentDelimiter)) {
      responses.forEach(
        (key, answer) {
          viewModel.message = viewModel.message.replaceAll(
            _Constants.percentDelimiter + key,
            answer.value,
          );
        },
      );
    }
    return viewModel;
  }
}
