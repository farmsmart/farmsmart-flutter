import 'dart:io';

import 'package:farmsmart_flutter/chat/ui/viewmodel/ChatResponseViewModel.dart';
import 'package:flutter/material.dart';

abstract class ChatFlow {
  Widget start({
    @required File file,
    @required Function(Map<String, ChatResponseViewModel>) onSuccess,
    @required Function(String) onError,
  });
}
