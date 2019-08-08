import 'package:farmsmart_flutter/chat/model/form/input_request_entity.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionViewModel.dart';
import 'package:flutter/material.dart';

abstract class InteractiveMessageHandler {
  Widget buildInputTextWidget({
    InputRequestEntity inputRequestEntity,
    TextEditingController textEditingController,
    Function onSendPressed,
    Function(String) onValidationPassed,
    InteractiveMessageType type,
    bool isFocusedOnBuild,
  });

  Widget buildSelectableOptionsWidget({
    InputRequestEntity inputRequestEntity,
    Function(SelectableOptionViewModel) onTap,
  });

  Widget buildDatePickerWidget({
    InputRequestEntity inputRequestEntity,
    Function(String) onSendPressed,
  });

}

enum InteractiveMessageType {
  inputString,
  inputEmail,
  inputPhoneNumber,
  inputImage,
  inputDate,
  inputDropdown,
  multiChoice,
}
