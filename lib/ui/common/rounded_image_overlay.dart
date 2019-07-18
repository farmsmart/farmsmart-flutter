import 'package:flutter/widgets.dart';

class RoundedImageOverlay extends StatelessWidget {
  final ImageProvider image;
  final double imageHeight;
  final double imageWidth;
  final BorderRadiusGeometry imageBorderRadius;
  final Color overlayColor;
  final bool showOverlay;
  final String overlayIcon;
  final double overlayIconHeight;
  final double overlayIconWidth;

  const RoundedImageOverlay({
    @required this.image,
    this.imageHeight = double.infinity,
    this.imageWidth = double.infinity,
    this.imageBorderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.overlayColor = const Color(0x26ffffff),
    this.showOverlay = false,
    this.overlayIcon,
    this.overlayIconHeight = double.infinity,
    this.overlayIconWidth = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        width: imageWidth,
        height: imageHeight,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: imageBorderRadius,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: image,
          ),
        ),
      ),
      _buildOverlay(),
    ]);
  }

  Widget _buildOverlay() {
    if (showOverlay) {
      return Container(
        width: double.infinity,
        height: imageHeight,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: imageBorderRadius,
          color: overlayColor,
        ),
        child: Center(
          child: Image(
            image: AssetImage(overlayIcon),
            width: overlayIconWidth,
            height: overlayIconHeight,
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
