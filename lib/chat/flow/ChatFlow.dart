import 'dart:io';

import 'package:flutter/material.dart';

abstract class ChatFlow {
  Widget start({
    @required File file,
    @required Function(Map<String, String>) onSuccess,
    @required Function(String) onError,
  });
}
