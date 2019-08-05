import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/bloc/transformer/implementation/SelectableOptionsViewModelTransformer.dart';
import 'package:farmsmart_flutter/chat/model/form/input_request_entity.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionViewModel.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionsViewModel.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/selectable_options.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/text_input.dart';
import 'package:intl/intl.dart';

import '../InteractiveMessageHandler.dart';

class _Strings {
  static const String sendText = "Send";
  static const String messageNotEmpty = "Message should not be empty";
  static const String inputHint = "Type a message";

  static const String notValidString = "Provided TEXT is not valid";
  static const String notValidEmail = "Provided EMAIL is not valid";
  static const String notValidPhone = "Provided PHONE is not valid";
}

class InteractiveMessageHandlerImpl implements InteractiveMessageHandler {
  @override
  Widget buildInputTextWidget({
    InputRequestEntity inputRequestEntity,
    TextEditingController textEditingController,
    Function onSendPressed,
    Function(String) onValidationPassed,
    InteractiveMessageType type,
    bool isFocusedOnBuild,
  }) {
    return _buildTextInputWidget(
      onSendPressed: onSendPressed,
      onValidationPassed: onValidationPassed,
      textEditingController: textEditingController,
      type: type,
      inputRequestEntity: inputRequestEntity,
      isFocusedOnBuild: isFocusedOnBuild,
    );
  }

  @override
  Widget buildSelectableOptionsWidget({
    InputRequestEntity inputRequestEntity,
    Function(SelectableOptionViewModel) onTap,
  }) {
    return _buildSelectableOptionsWidget(
      onTap: onTap,
      inputRequestEntity: inputRequestEntity,
    );
  }

  _buildTextInputWidget({
    InputRequestEntity inputRequestEntity,
    TextEditingController textEditingController,
    Function onSendPressed,
    Function(String) onValidationPassed,
    InteractiveMessageType type,
    bool isFocusedOnBuild,
  }) {
    return TextInput(
      buttonText: Intl.message(_Strings.sendText),
      formFieldValidatorFunction: _getValidationFunction(
        regex: inputRequestEntity.validationRegex,
        type: type,
        onValidationPassed: onValidationPassed,
      ),
      onSendPressed: onSendPressed,
      controller: textEditingController,
      decoration: _getInputDecoration(),
      isFocusedOnBuild: isFocusedOnBuild,
    );
  }

  _buildSelectableOptionsWidget({
    InputRequestEntity inputRequestEntity,
    Function(SelectableOptionViewModel) onTap,
  }) {
    return SelectableOptions(
      viewModel: _getSelectableOptionsViewModel(
        inputRequestEntity: inputRequestEntity,
      ),
      onTap: onTap,
    );
  }

  SelectableOptionsViewModel _getSelectableOptionsViewModel({
    InputRequestEntity inputRequestEntity,
  }) {
    return SelectableOptionsViewModelTransformer()
        .transform(from: inputRequestEntity);
  }

  String Function(String) _getValidationFunction({
    String regex,
    InteractiveMessageType type,
    Function(String) onValidationPassed,
  }) {
    return (value) {
      return _getFormFieldValidatorValue(
        value: value,
        regex: regex,
        type: type,
        onValidationPassed: onValidationPassed,
      );
    };
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(hintText: Intl.message(_Strings.inputHint));
  }

  String _getFormFieldValidatorValue({
    String value,
    String regex,
    InteractiveMessageType type,
    Function(String) onValidationPassed,
  }) {
    if (value.isEmpty) {
      return Intl.message(_Strings.messageNotEmpty);
    } else if (_isRegexProvided(regex: regex) &&
        !_isRegexValidationPassed(value: value, regex: regex)) {
      return _getErrorMessageByType(type: type);
    }
    onValidationPassed(value);
    return null;
  }

  String _getErrorMessageByType({InteractiveMessageType type}) {
    switch (type) {
      case InteractiveMessageType.inputString:
        return Intl.message(_Strings.notValidString);
      case InteractiveMessageType.inputEmail:
        return Intl.message(_Strings.notValidEmail);
      case InteractiveMessageType.inputPhoneNumber:
        return Intl.message(_Strings.notValidPhone);
      case InteractiveMessageType.inputImage:
        return null;
      case InteractiveMessageType.multiChoice:
        return null;
      default:
        return null;
    }
  }

  bool _isRegexValidationPassed({
    String value,
    String regex,
  }) {
    return RegExp(
      regex,
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(value);
  }

  bool _isRegexProvided({
    String regex,
  }) {
    return regex != null && regex.isNotEmpty;
  }
}
