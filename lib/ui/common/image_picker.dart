import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart' as ImagePickerLib
    show ImagePicker, ImageSource;
import 'package:intl/intl.dart';

class _Constants {
  static final EdgeInsets cropAreaPadding = const EdgeInsets.only(top: 20.0);
  static final Color cropStatusBarColor = const Color(0xffffffff);
  static final Color cropToolbarBarColor = const Color(0xffffffff);
  static const double defaultImageRatioX = 1.0;
  static const double defaultImageRatioY = 1.0;
}

class _LocalisedStrings {
  static String editPhoto() => Intl.message('Edit Photo');

  static String noImagePickedError() => Intl.message('No image picked');

  static String noCroppedImageError() => Intl.message('No cropped image');
}

class ImagePicker {
  static Future<bool> pickImage({
    @required Function(File) onSuccess,
    @required Function(String) onCancel,
    @required ImagePickerLib.ImageSource imageSource,
    @required int imageMaxHeight,
    @required int imageMaxWidth,
    bool circleShapeOnCrop = true,
    double imageRatioX = _Constants.defaultImageRatioX,
    double imageRatioY = _Constants.defaultImageRatioY,
  }) async {
    final file =
        await ImagePickerLib.ImagePicker.pickImage(source: imageSource);

    if (file == null) {
      onCancel(_LocalisedStrings.noImagePickedError());
      return false;
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
      toolbarTitle: _LocalisedStrings.editPhoto(),
      toolbarWidgetColor: Colors.black,
    );

    file.delete();

    if (croppedFile == null) {
      onCancel(_LocalisedStrings.noCroppedImageError());
      return false;
    }

    onSuccess(croppedFile);
    return true;
  }
}
