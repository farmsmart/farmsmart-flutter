import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';
import 'package:flutter/widgets.dart';

import 'image_provider_view.dart';

class RoundedImageOverlay extends StatelessWidget {
  final ImageURLProvider image;
  final double imageHeight;
  final double imageWidth;
  final BorderRadiusGeometry imageBorderRadius;
  final Color overlayColor;
  final bool showOverlayIcon;
  final String overlayIcon;
  final double overlayIconHeight;
  final double overlayIconWidth;

  const RoundedImageOverlay({
    @required this.image,
    this.imageHeight = double.infinity,
    this.imageWidth = double.infinity,
    this.imageBorderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.overlayColor = const Color(0x1425df0c),
    this.showOverlayIcon = false,
    this.overlayIcon,
    this.overlayIconHeight = double.infinity,
    this.overlayIconWidth = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      _buildMainImage(),
      _buildOverlay(),
    ]);
  }

  Widget _buildMainImage() {
    return Container(
      width: imageWidth,
      height: imageHeight,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: imageBorderRadius,
      ),
      child: ImageProviderView(
        imageURLProvider: image,
        imageBorderRadius: imageBorderRadius,
        width: imageWidth,
        height: imageHeight,
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      width: double.infinity,
      height: imageHeight,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: imageBorderRadius,
        color: overlayColor,
      ),
      child: Center(
        child: _buildOverlayIcon(),
      ),
    );
  }

  _buildOverlayIcon() {
    if (showOverlayIcon) {
      return Image(
        image: AssetImage(overlayIcon),
        width: overlayIconWidth,
        height: overlayIconHeight,
      );
    }
  }
}
