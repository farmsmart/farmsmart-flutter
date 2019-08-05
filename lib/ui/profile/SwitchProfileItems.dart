import 'package:farmsmart_flutter/ui/common/image_provider_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class _Icons {
  static final checkBox = "assets/icons/radio_button_default.png";
  static final activeCheckBox = "assets/icons/radio_button_active.png";
}

class _Constants {
  static final double imageSize = 48;
  static final double iconSize = 24;
  static final EdgeInsets iconEdgePadding =
      EdgeInsets.symmetric(horizontal: 32, vertical: 15);
}

class SwitchProfileItemsViewModel {
  final String title;
  ImageProvider image;
  final String icon;
  Function itemAction;
  bool isSelected;

  SwitchProfileItemsViewModel({
    this.title,
    this.image,
    this.icon,
    this.itemAction,
    this.isSelected,
  });
}

class SwitchProfileItemsStyle {
  final TextStyle titleTextStyle;

  const SwitchProfileItemsStyle({
    this.titleTextStyle,
  });

  SwitchProfileItemsStyle copyWith({
    TextStyle titleTextStyle,
  }) {
    return SwitchProfileItemsStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle);
  }
}

class _DefaultStyle extends SwitchProfileItemsStyle {
  final TextStyle titleTextStyle = const TextStyle(
    color: Color(0xff1a1b46),
    fontSize: 17,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  const _DefaultStyle({
    TextStyle titleTextStyle,
  });
}

const SwitchProfileItemsStyle _defaultStyle = const _DefaultStyle();

class SwitchProfileItems extends StatelessWidget {
  final SwitchProfileItemsViewModel _viewModel;
  final SwitchProfileItemsStyle _style;

  const SwitchProfileItems({
    Key key,
    SwitchProfileItemsViewModel viewModel,
    SwitchProfileItemsStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        Intl.message(_viewModel.title),
        style: _style.titleTextStyle,
      ),
      leading: ClipOval(
        child: Stack(
          children: <Widget>[
            Image(
              image: _viewModel.image,
              height: _Constants.imageSize,
              width: _Constants.imageSize,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ],
        ),
      ),
      trailing: Image.asset(
        _viewModel.isSelected ? _Icons.activeCheckBox : _Icons.checkBox,
        height: _Constants.iconSize,
      ),
      contentPadding: _Constants.iconEdgePadding,
      onTap: () => _viewModel.itemAction(),
    );
  }
}
