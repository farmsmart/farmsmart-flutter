import 'dart:io';

import 'package:farmsmart_flutter/chat/flow/implementation/ChatFlowFromFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return File("assets/responses/create_account_mock_form.json");
  }

  _doOnSuccess(BuildContext context, Map<String, String> map) {
    print("On Success recevied: ${map.toString()}");
    Navigator.pop(context);
  }

  _doOnError(BuildContext context, String error) {
    print("On Error recevied: ${error.toString()}");
    Navigator.pop(context);
  }
}
