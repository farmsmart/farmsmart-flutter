import 'dart:io';

import 'package:farmsmart_flutter/ui/common/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart' as ImagePickerLib;

class _Strings {
  static final noImage = 'No image';
}

class PlaygroundTakeImageTester extends StatefulWidget {
  final ImagePickerLib.ImageSource imageSource;

  PlaygroundTakeImageTester({Key key, this.imageSource});

  @override
  _PlaygroundTakeImageTesterState createState() =>
      _PlaygroundTakeImageTesterState();
}

class _PlaygroundTakeImageTesterState extends State<PlaygroundTakeImageTester> {
  File _file;

  @override
  void initState() {
    super.initState();

    ImagePicker.pickImage(
      imageSource: widget.imageSource,
      imageMaxHeight: 500,
      imageMaxWidth: 500,
      onSuccess: (imageFile) {
        setState(() {
          _file = imageFile;
        });
      },
      onCancel: (message) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _file != null ? Image.file(_file) : Text(_Strings.noImage),
    );
  }
}
