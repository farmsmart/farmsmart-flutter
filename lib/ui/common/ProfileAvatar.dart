import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/ui/profile/Profile.dart';
import 'package:flutter/material.dart';

import 'ViewModelProviderBuilder.dart';
import 'image_provider_view.dart';

class _Constants {
  static const defaultBackgroundColor = Color(0xffe9eaf2);
  static const defaultFontColor = Colors.black;
}

class ProfileAvatar extends StatelessWidget {
  final ViewModelProvider<ProfileViewModel> _viewModelProvider;
  final double _width;
  final double _height;
  final Color _backgroundColor;
  final TextStyle _textStyle;

  const ProfileAvatar({
    Key key,
    ViewModelProvider<ProfileViewModel> viewModelProvider,
    double width,
    double height,
    TextStyle textStyle,
    Color backgroundColor,
  })  : this._viewModelProvider = viewModelProvider,
        this._width = width,
        this._height = height,
        this._textStyle = textStyle,
        this._backgroundColor = backgroundColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProviderBuilder(
      provider: _viewModelProvider,
      successBuilder: _successBuilder,
    );
  }

  Widget _successBuilder({
    BuildContext context,
    AsyncSnapshot<ProfileViewModel> snapshot,
  }) {
    final avatarProvider = snapshot.data?.image;
    final initials = snapshot.data?.initials;
    Widget avatarWidget = SizedBox(
      width: _width,
      height: _height,
    );
    if (initials != null) {
      avatarWidget = Center(
          child: Text(
        initials,
        style: _textStyle ?? TextStyle(color: _Constants.defaultFontColor),
      ));
    }
    if (avatarProvider != null) {
      avatarWidget = ImageProviderView(
        imageURLProvider: avatarProvider,
        width: _width,
        height: _height,
      );
    }
    return Container(
        height: _width,
        width: _height,
        child: ClipOval(
          child: Container(
            child: avatarWidget,
            color: _backgroundColor ?? _Constants.defaultBackgroundColor,
          ),
        ));
  }
}
