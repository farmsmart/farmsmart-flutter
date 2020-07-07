import 'dart:async';

import 'package:farmsmart_flutter/chat/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/chat/bloc/handler/InteractiveMessageHandler.dart';
import 'package:farmsmart_flutter/chat/bloc/handler/implementation/InteractiveMessageHandlerImpl.dart';
import 'package:farmsmart_flutter/chat/bloc/handler/ChatMessageViewModelHandler.dart';
import 'package:farmsmart_flutter/chat/bloc/handler/implementation/ChatMessageProviderHelperImpl.dart';
import 'package:farmsmart_flutter/chat/model/form/input_request_entity.dart';
import 'package:farmsmart_flutter/chat/repository/form/ChatRepository.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/ChatResponseViewModel.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/bubble_message.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/chat.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/rounded_button.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/separator_wrapper.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/rounded_button_styles.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class _Constants {
  static const currentMessageIndex = 0;
  static const minMessagesLengthToUpdate = 3;
  static const previousMessageIndex = 1;
  static const defaultDelayDuration = 1000;
  static const defaultEmptyString = "";
  static const scrollAnimationOffset = 0.0;
  static const scrollAnimationDuration = 300;

  static final dateFormatter = DateFormat('dd MMMM yyyy');
  static const String typeValueString = "com.wearemobilefirst.String";
  static const String typeValueEmail = "com.wearemobilefirst.Email";
  static const String typeValuePhoneNumber = "com.wearemobilefirst.PhoneNumber";
  static const String typeValueImage = "com.wearemobilefirst.Image";
  static const String typeValueMultiChoice = "com.wearemobilefirst.MultiChoice";
  static const String typeValueDropdown = "com.wearemobilefirst.Dropdown";
  static const String typeValueDate = "com.wearemobilefirst.Date";
}

class _LocalisedStrings {
  static String summaryError() =>
      Intl.message("Provided summary is not correct");

  static String viewDetails() => Intl.message("View Your Details");
}

class ChatProvider implements ViewModelProvider<ChatViewModel> {
  final ChatRepository _repo;
  final ChatMessageViewModelHandler _chatMessageHandler =
      ChatMessageViewModelHandlerImpl();
  final InteractiveMessageHandler _interactiveMessageHandler =
      InteractiveMessageHandlerImpl();
  final TextEditingController _textEditingController = TextEditingController();
  final Function(Map<String, ChatResponseViewModel>) _onSuccess;
  final Function(String) _onError;

  ChatViewModel _chatViewModel;
  int _currentMessageCount = _Constants.currentMessageIndex;
  Map<String, ChatResponseViewModel> _responseMap = {};

  ChatProvider({
    @required ChatRepository repository,
    Function(Map<String, ChatResponseViewModel>) onSuccess,
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
            _chatMessageHandler.getMessageFromEntity(formItem, _responseMap));
        _increaseMessageCount();
        _updatePreviousMessages();
        _setInteractiveWidget(formItem.inputRequest);
        _notifyController();
      } else {
        _setSummaryDetailsButton();
      }
    });
  }

  void _setSummaryDetailsButton() {
    _chatViewModel.interactiveWidget = SeparatorWrapper(
      wrappedChild: RoundedButton(
        viewModel: RoundedButtonViewModel(
          title: _LocalisedStrings.viewDetails(),
          onTap: _onSummaryWidgetActionButtonTap,
        ),
        style: RoundedButtonStyles.chatButtonStyle(),
      ),
    );
  }

  void _onSummaryWidgetActionButtonTap() {
    (_responseMap != null && _responseMap.isNotEmpty)
        ? _onSuccess(_responseMap)
        : _onError(_LocalisedStrings.summaryError());
  }

  void _setInteractiveWidget(InputRequestEntity entity) {
    if (entity != null && entity.type != null) {
      InteractiveMessageType inputType = _getInputType(entity);
      switch (inputType) {
        case InteractiveMessageType.inputDate:
          _setDatePickerWidget(entity: entity);
          break;
        case InteractiveMessageType.inputDropdown:
          _setDropdownWidget(entity: entity);
          break;
        case InteractiveMessageType.multiChoice:
          _setSelectableOptionsWidget(entity: entity);
          break;
        default:
          _setInputTextWidget(
            entity: entity,
            inputType: inputType,
          );
          break;
      }
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
      case _Constants.typeValueMultiChoice:
        return InteractiveMessageType.multiChoice;
      case _Constants.typeValueDropdown:
        return InteractiveMessageType.inputDropdown;
      case _Constants.typeValueDate:
        return InteractiveMessageType.inputDate;
      default:
        return null;
    }
  }

  void _setInputTextWidget({
    InteractiveMessageType inputType,
    InputRequestEntity entity,
  }) =>
      _chatViewModel.interactiveWidget =
          _interactiveMessageHandler.buildInputTextWidget(
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
            value: ChatResponseViewModel(
              id: entity.uri,
              title: entity.title,
              value: value,
            ),
          );
        },
      );

  void _setSelectableOptionsWidget({
    InputRequestEntity entity,
  }) =>
      _chatViewModel.interactiveWidget =
          _interactiveMessageHandler.buildSelectableOptionsWidget(
        inputRequestEntity: entity,
        onTap: (option) {
          _cleanInteractiveWidget();
          _getNextMessageByProvided(option.title);
          _putResponseToTheMap(
            key: entity.uri,
            value: ChatResponseViewModel(
              id: option.id,
              title: entity.title,
              value: option.title,
            ),
          );
        },
      );

  void _setDatePickerWidget({
    InputRequestEntity entity,
  }) =>
      _chatViewModel.interactiveWidget =
          _interactiveMessageHandler.buildDatePickerWidget(
        onSendPressed: (dateValue) {
          _cleanInteractiveWidget();
          _getNextMessageByProvided(_formatDate(dateValue));
          _putResponseToTheMap(
            key: entity.uri,
            value: ChatResponseViewModel(
              id: entity.uri,
              title: entity.title,
              value: dateValue,
            ),
          );
        },
      );

  String _formatDate(DateTime date) => _Constants.dateFormatter.format(date);

  void _setDropdownWidget({InputRequestEntity entity}) =>
      _chatViewModel.interactiveWidget =
          _interactiveMessageHandler.buildDropDownPickerWidget(
        inputRequestEntity: entity,
        onSendPressed: (option) {
          _cleanInteractiveWidget();
          _getNextMessageByProvided(option.title);
          _putResponseToTheMap(
            key: entity.uri,
            value: ChatResponseViewModel(
              id: option.id,
              title: entity.title,
              value: option.title,
            ),
          );
        },
      );

  void _putResponseToTheMap({String key, ChatResponseViewModel value}) {
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

  void _updatePreviousMessages() {
    List<MessageBubbleViewModel> messageViewModels =
        _chatViewModel.messageViewModels;
    if (messageViewModels.length >= _Constants.minMessagesLengthToUpdate) {
      MessageBubbleViewModel currentViewModel =
          messageViewModels[_Constants.currentMessageIndex];
      MessageBubbleViewModel previousViewModel =
          messageViewModels[_Constants.previousMessageIndex];
      _updateReceivedMessages(
        currentViewModel: currentViewModel,
        previousViewModel: previousViewModel,
      );
    }
  }

  void _updateReceivedMessages({
    MessageBubbleViewModel currentViewModel,
    MessageBubbleViewModel previousViewModel,
  }) {
    switch (previousViewModel.messageType) {
      case MessageType.sent:
        currentViewModel.messageType = MessageType.received;
        break;
      case MessageType.received:
        _updateFromReceived(
          currentViewModel: currentViewModel,
          previousViewModel: previousViewModel,
        );
        break;
      case MessageType.receivedStackBottom:
        _updateFromReceivedStackBottom(
          previousViewModel: previousViewModel,
          currentViewModel: currentViewModel,
        );
        break;
      default: //nothing
    }
  }

  void _updateFromReceived({
    MessageBubbleViewModel currentViewModel,
    MessageBubbleViewModel previousViewModel,
  }) {
    if (currentViewModel.messageType == MessageType.received) {
      previousViewModel.messageType = MessageType.receivedStackTop;
      currentViewModel.messageType = MessageType.receivedStackBottom;
    }
  }

  void _updateFromReceivedStackBottom({
    MessageBubbleViewModel currentViewModel,
    MessageBubbleViewModel previousViewModel,
  }) {
    if (currentViewModel.messageType == MessageType.received) {
      previousViewModel.messageType = MessageType.receivedStackBetween;
      currentViewModel.messageType = MessageType.receivedStackBottom;
    }
  }
}
