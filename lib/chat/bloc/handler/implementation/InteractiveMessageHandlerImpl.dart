import 'package:farmsmart_flutter/chat/bloc/transformer/implementation/SelectableOptionsViewModelTransformer.dart';
import 'package:farmsmart_flutter/chat/model/form/input_request_entity.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionViewModel.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionsViewModel.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/date_picker.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/drop_down_picker.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/pair_container_wrapper.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/rounded_button.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/selectable_options.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/separator_wrapper.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/date_picker_styles.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/drop_down_picker_styles.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/pair_container_wrapper_styles.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/rounded_button_styles.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/selectable_options_styles.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/separator_wrapper_styles.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/text_input_styles.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/text_input.dart';
import 'package:flutter/material.dart';
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
  }) =>
      _buildTextInputWidget(
        onSendPressed: onSendPressed,
        onValidationPassed: onValidationPassed,
        textEditingController: textEditingController,
        type: type,
        inputRequestEntity: inputRequestEntity,
        isFocusedOnBuild: isFocusedOnBuild,
      );

  @override
  Widget buildSelectableOptionsWidget({
    InputRequestEntity inputRequestEntity,
    Function(SelectableOptionViewModel) onTap,
  }) =>
      _buildSelectableOptionsWidget(
        onTap: onTap,
        inputRequestEntity: inputRequestEntity,
      );

  @override
  Widget buildDatePickerWidget({
    Function(DateTime) onSendPressed,
  }) =>
      _buildDatePicker(
        onSendPressed: onSendPressed,
      );

  @override
  Widget buildDropDownPickerWidget({
    InputRequestEntity inputRequestEntity,
    Function(SelectableOptionViewModel) onSendPressed,
  }) =>
      _buildDropDownPicker(
        onSendPressed: onSendPressed,
        inputRequestEntity: inputRequestEntity,
      );

  Widget _buildTextInputWidget({
    InputRequestEntity inputRequestEntity,
    TextEditingController textEditingController,
    Function onSendPressed,
    Function(String) onValidationPassed,
    InteractiveMessageType type,
    bool isFocusedOnBuild,
  }) {
    TextInput textInput = _buildTextInput(
      isFocusedOnBuild: isFocusedOnBuild,
      onValidationPassed: onValidationPassed,
      inputRequestEntity: inputRequestEntity,
      type: type,
      textEditingController: textEditingController,
    );
    GlobalKey<FormState> formKey = textInput.formKey;
    return SeparatorWrapper(
      wrappedChild: PairContainerWrapper(
        leftChild: textInput,
        rightChild: RoundedButton(
          viewModel: RoundedButtonViewModel(
              title: _LocalisedStrings.sendText(),
              onTap: () {
                formKey.currentState.validate();
                onSendPressed();
              }),
          style: RoundedButtonStyles.chatButtonStyle(),
        ),
        style: PairContainerWrapperStyles.buildDefaultStyle(),
      ),
      style: SeparatorWrapperStyles.buildDefaultStyle(),
    );
  }

  Widget _buildTextInput({
    InputRequestEntity inputRequestEntity,
    TextEditingController textEditingController,
    Function(String) onValidationPassed,
    InteractiveMessageType type,
    bool isFocusedOnBuild,
  }) =>
      TextInput(
        formFieldValidatorFunction: _getValidationFunction(
          regex: inputRequestEntity.validationRegex,
          type: type,
          onValidationPassed: onValidationPassed,
        ),
        controller: textEditingController,
        decoration: _getInputDecoration(),
        isFocusedOnBuild: isFocusedOnBuild,
        style: TextInputStyles.buildDefaultStyle(),
      );

  Widget _buildSelectableOptionsWidget({
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
        style: SeparatorWrapperStyles.buildDefaultStyle(),
      );

  Widget _buildDatePicker({
    Function(DateTime) onSendPressed,
  }) {
    DateTime selectedDate;
    return SeparatorWrapper(
      wrappedChild: PairContainerWrapper(
        leftChild: DatePicker(
          onDateSelected: (date) {
            selectedDate = date;
          },
          style: DatePickerStyles.buildDefaultStyle(),
        ),
        rightChild: RoundedButton(
          viewModel: RoundedButtonViewModel(
            onTap: () => onSendPressed(selectedDate),
            title: _LocalisedStrings.sendText(),
          ),
          style: RoundedButtonStyles.chatButtonStyle(),
        ),
        style: PairContainerWrapperStyles.buildDefaultStyle(),
      ),
      style: SeparatorWrapperStyles.buildDefaultStyle(),
    );
  }

  Widget _buildDropDownPicker({
    Function(SelectableOptionViewModel) onSendPressed,
    InputRequestEntity inputRequestEntity,
  }) {
    SelectableOptionViewModel selectedOption;
    return SeparatorWrapper(
      wrappedChild: PairContainerWrapper(
        leftChild: DropDownPicker(
          viewModel: _getSelectableOptionsViewModel(
            inputRequestEntity: inputRequestEntity,
          ),
          onOptionSelected: (option) {
            selectedOption = option;
          },
          style: DropDownPickerStyles.buildDefaultStyle(),
        ),
        rightChild: RoundedButton(
          viewModel: RoundedButtonViewModel(
            onTap: () => onSendPressed(selectedOption),
            title: _LocalisedStrings.sendText(),
          ),
          style: RoundedButtonStyles.chatButtonStyle(),
        ),
        style: PairContainerWrapperStyles.buildDefaultStyle(),
      ),
      style: SeparatorWrapperStyles.buildDefaultStyle(),
    );
  }

  SelectableOptionsViewModel _getSelectableOptionsViewModel({
    InputRequestEntity inputRequestEntity,
  }) =>
      SelectableOptionsViewModelTransformer()
          .transform(from: inputRequestEntity);

  String Function(String) _getValidationFunction({
    String regex,
    InteractiveMessageType type,
    Function(String) onValidationPassed,
  }) =>
      (value) {
        return _getFormFieldValidatorValue(
          value: value,
          regex: regex,
          type: type,
          onValidationPassed: onValidationPassed,
        );
      };

  InputDecoration _getInputDecoration() => InputDecoration(
        border: InputBorder.none,
        hintText: _LocalisedStrings.inputHint(),
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
  }) =>
      RegExp(
        regex,
        caseSensitive: false,
        multiLine: false,
      ).hasMatch(value);

  bool _isRegexProvided({
    String regex,
  }) =>
      regex != null && regex.isNotEmpty;
}
