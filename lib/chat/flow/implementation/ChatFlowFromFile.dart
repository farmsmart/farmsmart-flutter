import 'dart:io';

import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/bloc/provider/ChatProvider.dart';
import 'package:farmsmart_flutter/chat/repository/form/implementation/JSONFileFormRepository.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/chat.dart';

import '../ChatFlow.dart';

class ChatFlowFromFile implements ChatFlow {
  final BuildContext _context;

  ChatFlowFromFile(BuildContext context) : this._context = context;

  @override
  Widget start({File file, onSuccess, onError}) {
    return Chat(
      chatProvider: ChatProvider(
        repository: JSONFileFormRepository(
          context: _context,
          file: file,
        ),
        onSuccess: onSuccess,
        onError: onError,
      ),
    );
  }
}
