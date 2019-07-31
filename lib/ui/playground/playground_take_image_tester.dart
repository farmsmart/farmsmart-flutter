import 'dart:io';

import 'package:farmsmart_flutter/ui/common/take_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class PlaygroundTakeImageTester extends StatefulWidget {
  final ImageSource imageSource;

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

    TakeImage(
      imageSource: widget.imageSource,
      imageMaxHeight: 500,
      imageMaxWidth: 500,
      onImageTaken: (imageFile) {
        setState(() {
          _file = imageFile;
        });
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
      child: _file != null ? Image.file(_file) : SizedBox.shrink(),
    );
  }
}
