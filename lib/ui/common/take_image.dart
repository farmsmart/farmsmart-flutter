import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class _Constants {
  static final EdgeInsets cropAreaPadding = const EdgeInsets.only(top: 20.0);
  static final Color cropStatusBarColor = const Color(0xffffffff);
  static final Color cropToolbarBarColor = const Color(0xffffffff);
  static const double defaultImageRatioX = 1.0;
  static const double defaultImageRatioY = 1.0;
}

class _Strings {
  static final editPhoto = 'Edit Photo';
}

class TakeImage {

  final ImageSource imageSource;
  final int imageMaxHeight;
  final int imageMaxWidth;
  final void Function(File) onImageTaken;
  final bool circleShapeOnCrop;
  final double imageRatioX;
  final double imageRatioY;


  TakeImage({
    @required this.imageSource,
    @required this.imageMaxHeight,
    @required this.imageMaxWidth,
    @required this.onImageTaken,
    this.circleShapeOnCrop = true,
    this.imageRatioX = _Constants.defaultImageRatioX,
    this.imageRatioY = _Constants.defaultImageRatioY,
  }) {
    _takeImage();
  }

  Future<void> _takeImage() async {
    final file = await ImagePicker.pickImage(source: imageSource);

    if (file == null) {
      return;
    }

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: file.path,
      ratioX: imageRatioX,
      ratioY: imageRatioY,
      maxWidth: imageMaxWidth,
      maxHeight: imageMaxHeight,
      circleShape: circleShapeOnCrop,
      statusBarColor: _Constants.cropStatusBarColor,
      toolbarColor: _Constants.cropToolbarBarColor,
      toolbarTitle: Intl.message(_Strings.editPhoto),
      toolbarWidgetColor: Colors.black,
    );

    if (croppedFile == null) {
      return;
    }

    onImageTaken(croppedFile);
  }
}
