import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart' as ImagePickerLib
    show ImagePicker, ImageSource;
import 'package:intl/intl.dart';

class _Constants {
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

    AndroidUiSettings androidSettings = AndroidUiSettings(
      toolbarTitle: _LocalisedStrings.editPhoto(),
      toolbarColor: _Constants.cropToolbarBarColor,
      toolbarWidgetColor: Colors.black,
      statusBarColor: _Constants.cropStatusBarColor,
    );
    IOSUiSettings iosSettings =
        IOSUiSettings(title: _LocalisedStrings.editPhoto());

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: imageRatioX, ratioY: imageRatioY),
      maxWidth: imageMaxWidth,
      maxHeight: imageMaxHeight,
      cropStyle: CropStyle.circle,
      androidUiSettings: androidSettings,
      iosUiSettings: iosSettings,
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
