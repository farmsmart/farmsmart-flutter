import 'package:farmsmart_flutter/chat/model/form/form_entity.dart';
import 'package:farmsmart_flutter/chat/model/form/form_item_entity.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/ChatResponseViewModel.dart';

abstract class ChatMessageViewModelHandler<T> {
  T getHeaderMessage(FormEntity entity);

  T getMessageFromEntity(
      FormItemEntity entity, Map<String, ChatResponseViewModel> responses);

  T getMessageFromString(String providedMessage);

  T getLoadingMessage();
}
