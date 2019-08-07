import 'dart:async';

import 'package:farmsmart_flutter/chat/ui/widgets/card_view.dart';
import 'package:flutter/widgets.dart';
import 'package:farmsmart_flutter/chat/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/chat/bloc/handler/InteractiveMessageHandler.dart';
import 'package:farmsmart_flutter/chat/bloc/handler/implementation/InteractiveMessageHandlerImpl.dart';
import 'package:farmsmart_flutter/chat/bloc/helper/ChatMessageProviderHelper.dart';
import 'package:farmsmart_flutter/chat/bloc/helper/implementation/ChatMessageProviderHelperImpl.dart';
import 'package:farmsmart_flutter/chat/bloc/helper/ChatSummaryProviderHelper.dart';
import 'package:farmsmart_flutter/chat/bloc/helper/implementation/ChatSummaryProviderHelperImpl.dart';
import 'package:farmsmart_flutter/chat/model/form/input_request_entity.dart';
import 'package:farmsmart_flutter/chat/repository/form/ChatRepository.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/bubble_message.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/chat.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/summary.dart';
import 'package:intl/intl.dart';

class _Constants {
  static const currentMessageIndex = 0;
  static const minMessagesLengthToUpdate = 3;
  static const previousMessageIndex = 1;
  static const defaultSizedBoxWidth = 40.0;
  static const defaultDelayDuration = 2000;
  static const defaultEmptyString = "";
  static const scrollAnimationOffset = 0.0;
  static const scrollAnimationDuration = 300;

  static const String typeValueString = "com.wearemobilefirst.String";
  static const String typeValueEmail = "com.wearemobilefirst.Email";
  static const String typeValuePhoneNumber = "com.wearemobilefirst.PhoneNumber";
  static const String typeValueImage = "com.wearemobilefirst.Image";
  static const String typeValueMultiChoice = "com.wearemobilefirst.MultiChoice";
}

class _Strings {
  static const String summaryTitleValue = "Chat summary value";
  static const String summaryTitleLabel = "Chat summary";
  static const String summaryActionButtonText = "Confirm";
  static const String summaryError = "Provided summary is not correct";
}

class ChatProvider implements ViewModelProvider<ChatViewModel> {
  final ChatRepository _repo;
  final ChatMessageProviderHelper _chatMessageHandler =
      ChatMessageProviderHelperImpl();
  final ChatSummaryProviderHelper _chatSummaryProviderHelper =
      ChatSummaryProviderHelperImpl();
  final InteractiveMessageHandler _interactiveMessageHandler =
      InteractiveMessageHandlerImpl();
  final TextEditingController _textEditingController = TextEditingController();
  final Function(Map<String, String>) _onSuccess;
  final Function(String) _onError;

  ChatViewModel _chatViewModel;
  int _currentMessageCount = _Constants.currentMessageIndex;
  Map<String, String> _responseMap = Map<String, String>();

  ChatProvider({
    @required ChatRepository repository,
    Function(Map<String, String>) onSuccess,
    Function(String) onError,
  })  : this._repo = repository,
        this._onSuccess = onSuccess ?? (() => {}),
        this._onError = onError ?? (() => {});

  final StreamController<ChatViewModel> _controller =
      StreamController<ChatViewModel>.broadcast();

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }

  @override
  ChatViewModel initial() {
    _chatViewModel = _initialViewModel();
    _insertHeaderMessage();
    return _chatViewModel;
  }

  @override
  StreamController<ChatViewModel> observe() {
    return _controller;
  }

  @override
  ChatViewModel snapshot() {
    return _chatViewModel;
  }

  void _showMessageWithDelay() {
    _insertLoadingMessage();
    Future.delayed(
        const Duration(milliseconds: _Constants.defaultDelayDuration), () {
      _removeLoadingMessage();
      _nextMessage();
    });
  }

  void _getNextMessageByProvided(String message) {
    _nextMessage(providedMessage: message);
    _scrollToBottom();
  }

  void _nextMessage({String providedMessage = _Constants.defaultEmptyString}) {
    if (providedMessage.isNotEmpty) {
      _insertProvidedMessage(providedMessage);
    } else {
      _insertMessageFromService();
    }
    _scrollToBottom();
  }

  void _insertProvidedMessage(String providedMessage) {
    _insertNewMessageToList(
        _chatMessageHandler.getMessageFromString(providedMessage));
    _notifyController();
    _showMessageWithDelay();
  }

  void _insertLoadingMessage() {
    _insertNewMessageToList(_chatMessageHandler.getLoadingMessage());
    _notifyController();
  }

  void _removeLoadingMessage() {
    _chatViewModel.messageViewModels.removeAt(_Constants.currentMessageIndex);
    _notifyController();
  }

  void _insertMessageFromService() {
    _repo.getFormItem(_currentMessageCount).then((formItem) {
      if (formItem != null) {
        _insertNewMessageToList(
            _chatMessageHandler.getMessageFromEntity(formItem));
        _increaseMessageCount();
        _updateAvatarVisibility();
        _setInteractiveWidget(formItem.inputRequest);
        _notifyController();
      } else {
        _setSummaryWidget();
      }
    });
  }

  void _setSummaryWidget() {
    _chatViewModel.interactiveWidget = CardView(
      child: Summary(
        viewModel: _chatSummaryProviderHelper.getSummary(
          inputModel: _responseMap,
          titleValue: _Strings.summaryTitleValue,
          titleText: _Strings.summaryTitleLabel.toUpperCase(),
          actionText: _Strings.summaryActionButtonText,
        ),
        onTap: _onSummaryWidgetActionButtonTap,
      ),
    );
  }

  void _onSummaryWidgetActionButtonTap() {
    (_responseMap != null && _responseMap.isNotEmpty)
        ? _onSuccess(_responseMap)
        : _onError(_Strings.summaryError);
  }

  void _setInteractiveWidget(InputRequestEntity entity) {
    if (entity != null && entity.type != null) {
      InteractiveMessageType inputType = _getInputType(entity);
      inputType != null
          ? _chatViewModel.interactiveWidget = _buildInputTextWidget(
              entity: entity,
              inputType: inputType,
            )
          : _chatViewModel.interactiveWidget =
              _buildSelectableOptionsWidget(entity: entity);
    } else {
      _cleanInteractiveWidget();
      _showMessageWithDelay();
    }
  }

  InteractiveMessageType _getInputType(InputRequestEntity entity) {
    switch (entity.type) {
      case _Constants.typeValueString:
        return InteractiveMessageType.inputString;
      case _Constants.typeValueEmail:
        return InteractiveMessageType.inputEmail;
      case _Constants.typeValuePhoneNumber:
        return InteractiveMessageType.inputPhoneNumber;
      case _Constants.typeValueImage:
        return InteractiveMessageType.inputImage;
      default:
        return null;
    }
  }

  Widget _buildInputTextWidget({
    InteractiveMessageType inputType,
    InputRequestEntity entity,
  }) {
    return _interactiveMessageHandler.buildInputTextWidget(
      inputRequestEntity: entity,
      textEditingController: _textEditingController,
      onSendPressed: () => {},
      type: inputType,
      isFocusedOnBuild: true,
      onValidationPassed: (value) {
        _cleanKeyboard();
        _cleanInteractiveWidget();
        _getNextMessageByProvided(value);
        _putResponseToTheMap(
          key: entity.uri,
          value: value,
        );
      },
    );
  }

  Widget _buildSelectableOptionsWidget({
    InputRequestEntity entity,
  }) {
    return _interactiveMessageHandler.buildSelectableOptionsWidget(
      inputRequestEntity: entity,
      onTap: (option) {
        _cleanInteractiveWidget();
        _getNextMessageByProvided(option.title);
        _putResponseToTheMap(key: entity.uri, value: option.id);
      },
    );
  }

  void _putResponseToTheMap({String key, String value}) {
    _responseMap[key] = value;
  }

  void _cleanInteractiveWidget() {
    _chatViewModel.interactiveWidget = null;
  }

  void _cleanKeyboard() {
    _textEditingController.clear();
  }

  void _insertHeaderMessage() {
    _repo.getForm().then((form) {
      if (form != null) {
        _insertNewMessageToList(_chatMessageHandler.getHeaderMessage(form));
        _notifyController();
        _showMessageWithDelay();
      }
    });
  }

  void _insertNewMessageToList(MessageBubbleViewModel viewModel) {
    _chatViewModel.messageViewModels.insert(
      _Constants.currentMessageIndex,
      viewModel,
    );
  }

  void _notifyController() {
    _controller.sink.add(_chatViewModel);
  }

  void _increaseMessageCount() {
    _currentMessageCount++;
  }

  ChatViewModel _initialViewModel() {
    return ChatViewModel();
  }

  void _scrollToBottom() {
    _chatViewModel.scrollController.animateTo(
      _Constants.scrollAnimationOffset,
      curve: Curves.easeOut,
      duration:
          const Duration(milliseconds: _Constants.scrollAnimationDuration),
    );
  }

  void _updateAvatarVisibility() {
    List<MessageBubbleViewModel> messageViewModels =
        _chatViewModel.messageViewModels;
    if (messageViewModels.length >= _Constants.minMessagesLengthToUpdate) {
      MessageBubbleViewModel currentViewModel =
          messageViewModels[_Constants.currentMessageIndex];
      MessageBubbleViewModel previousViewModel =
          messageViewModels[_Constants.previousMessageIndex];
      if (currentViewModel.messageType == MessageType.received &&
          previousViewModel.messageType == MessageType.received) {
        previousViewModel.avatar = _buildDefaultAvatarEmptyBox();
      }
    }
  }

  Widget _buildDefaultAvatarEmptyBox() {
    return SizedBox(width: _Constants.defaultSizedBoxWidth);
  }
}
