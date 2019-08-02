import 'package:farmsmart_flutter/chat/model/form/form_entity.dart';
import 'package:farmsmart_flutter/chat/model/form/form_item_entity.dart';

abstract class ChatMessageProviderHelper<T> {
  T getHeaderMessage(FormEntity entity);

  T getMessageFromEntity(FormItemEntity entity);

  T getMessageFromString(String providedMessage);

  T getLoadingMessage();
}
