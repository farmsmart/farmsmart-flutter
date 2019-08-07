import 'dart:io';

import 'package:farmsmart_flutter/chat/flow/implementation/ChatFlowFromFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const defaultPathToJSONFile =
      "assets/responses/farmsmart_chat_ui_flow.json";
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChatFlowFromFile(context).start(
      file: _createChatFile(),
      onSuccess: (map) {
        _doOnSuccess(context, map);
      },
      onError: (error) {
        _doOnError(context, error);
      },
    );
  }

  File _createChatFile() {
    return File(_Constants.defaultPathToJSONFile);
  }

  _doOnSuccess(BuildContext context, Map<String, String> map) {
    print("On Success recevied: ${map.toString()}");
    Navigator.of(context).pop();
  }

  _doOnError(BuildContext context, String error) {
    print("On Error recevied: ${error.toString()}");
    Navigator.of(context).pop();
  }
}
