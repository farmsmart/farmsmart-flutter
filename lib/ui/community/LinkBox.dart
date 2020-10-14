import 'package:flutter/material.dart';

class _Constants {
  static const Color defaultCardBackgroundColor = Color(0xfff5f8fa);
  static final BorderRadius cardBorderRadius = BorderRadius.circular(12);
  static final EdgeInsets cardInnerPadding =
      EdgeInsets.only(left: 24, right: 30, top: 20, bottom: 22.5);
  static final EdgeInsets cardEdgePadding =
      EdgeInsets.only(left: 32, right: 32, top: 38.5);
  static final double imageLineSpace = 20;
  static final double titleLineSpace = 3;
  static final TextStyle titleTextStyle = TextStyle(
    color: Color(0xff1a1b46),
    fontSize: 15,
    height: 1.05,
    fontWeight: FontWeight.w500,
  );
  static final int detailTextMaxLines = 2;
  static final TextStyle detailTextStyle = TextStyle(
    color: Color(0xff4c4e6e),
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
  static final double imageContainerSize = 40;
  static final EdgeInsets imageEdgePadding = EdgeInsets.all(6);
  static const Color imageContainerColor = Color(0xff25d366);
  static final double imageSize = 10;
}

class LinkBoxViewModel {
  final String titleText;
  final String detailText;
  final IconData icon;
  final Function onTap;
  final String image;

  LinkBoxViewModel({
    @required this.titleText,
    @required this.detailText,
    @required this.onTap,
    this.icon,
    this.image,
  });
}

class LinkBoxStyle {
  final Color iconColor;
  final Color cardBackgroundColor;
  final Color imageContainerColor;

  const LinkBoxStyle({
    this.iconColor,
    this.cardBackgroundColor,
    this.imageContainerColor,
  });

  LinkBoxStyle copyWith({
    Color iconColor,
    Color cardBackgroundColor,
    Color imageContainerColor,
  }) {
    return LinkBoxStyle(
      iconColor: iconColor ?? this.iconColor,
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
      imageContainerColor: imageContainerColor ?? this.imageContainerColor,
    );
  }
}

class _DefaultStyle extends LinkBoxStyle {
  final Color iconColor = Colors.white;
  final Color cardBackgroundColor = _Constants.defaultCardBackgroundColor;
  final Color imageContainerColor = _Constants.imageContainerColor;

  const _DefaultStyle({
    Color iconColor,
    Color cardBackgroundColor,
    Color imageContainerColor,
  });
}

const LinkBoxStyle _defaultStyle = const _DefaultStyle();

class LinkBox extends StatelessWidget {
  final LinkBoxViewModel _viewModel;
  final LinkBoxStyle _style;

  const LinkBox({
    Key key,
    LinkBoxViewModel viewModel,
    LinkBoxStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _viewModel.onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: _style.cardBackgroundColor,
          borderRadius: _Constants.cardBorderRadius,
        ),
        padding: _Constants.cardInnerPadding,
        margin: _Constants.cardEdgePadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: _Constants.cardBorderRadius,
              child: Container(
                height: _Constants.imageContainerSize,
                width: _Constants.imageContainerSize,
                padding: _Constants.imageEdgePadding,
                color: _style.imageContainerColor,
                child: _buildImage(),
              ),
            ),
            SizedBox(
              width: _Constants.imageLineSpace,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildTitleText(),
                  SizedBox(
                    height: _Constants.titleLineSpace,
                  ),
                  _buildDetailText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildImage() {
    if (_viewModel.image != null) {
      return Image.asset(
        _viewModel.image,
        height: _Constants.imageSize,
        width: _Constants.imageSize,
      );
    } else if (_viewModel.icon != null) {
      return Icon(
        _viewModel.icon,
        color: _style.iconColor,
      );
    }
  }

  Text _buildTitleText() {
    return Text(
      _viewModel.titleText,
      style: _Constants.titleTextStyle,
    );
  }

  Text _buildDetailText() {
    return Text(
      _viewModel.detailText,
      maxLines: _Constants.detailTextMaxLines,
      overflow: TextOverflow.ellipsis,
      style: _Constants.detailTextStyle,
    );
  }
}
