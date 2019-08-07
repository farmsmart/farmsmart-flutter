import 'package:farmsmart_flutter/chat/ui/widgets/separator_wrapper.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/rounded_button_styles.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/selectable_options_styles.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/bloc/transformer/implementation/SelectableOptionsViewModelTransformer.dart';
import 'package:farmsmart_flutter/chat/model/form/input_request_entity.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionViewModel.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionsViewModel.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/selectable_options.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/text_input.dart';
import 'package:intl/intl.dart';
import '../InteractiveMessageHandler.dart';

class _LocalisedStrings {
  static String sendText() => Intl.message('Send');

  static String messageNotEmpty() =>
      Intl.message('Message should not be empty');

  static String inputHint() => Intl.message('Type a message');

  static String notValidString() => Intl.message('Provided TEXT is not valid');

  static String notValidEmail() => Intl.message("Provided EMAIL is not valid");

  static String notValidPhone() => Intl.message('Provided PHONE is not valid');
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
  }) =>
      SeparatorWrapper(
        wrappedChild: TextInput(
          buttonText: _LocalisedStrings.sendText(),
          formFieldValidatorFunction: _getValidationFunction(
            regex: inputRequestEntity.validationRegex,
            type: type,
            onValidationPassed: onValidationPassed,
          ),
          onSendPressed: onSendPressed,
          controller: textEditingController,
          decoration: _getInputDecoration(),
          isFocusedOnBuild: isFocusedOnBuild,
          roundedButtonStyle: RoundedButtonStyles.chatButtonStyle(),
        ),
      );

  _buildSelectableOptionsWidget({
    InputRequestEntity inputRequestEntity,
    Function(SelectableOptionViewModel) onTap,
  }) =>
      SeparatorWrapper(
        wrappedChild: SelectableOptions(
          viewModel: _getSelectableOptionsViewModel(
            inputRequestEntity: inputRequestEntity,
          ),
          onTap: onTap,
          style: SelectableOptionsStyles.buildDefaultStyle(),
        ),
      );

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

  InputDecoration _getInputDecoration() => InputDecoration(
        hintText: _LocalisedStrings.inputHint(),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(width: 1.0, color: Colors.red),
        ),
      );

  String _getFormFieldValidatorValue({
    String value,
    String regex,
    InteractiveMessageType type,
    Function(String) onValidationPassed,
  }) {
    if (value.isEmpty) {
      return _LocalisedStrings.messageNotEmpty();
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
        return _LocalisedStrings.notValidString();
      case InteractiveMessageType.inputEmail:
        return _LocalisedStrings.notValidEmail();
      case InteractiveMessageType.inputPhoneNumber:
        return _LocalisedStrings.notValidPhone();
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
