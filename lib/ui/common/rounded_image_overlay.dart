import 'package:flutter/widgets.dart';

class _Constants {
  static final startWithAssets = 'assets/';
}

class RoundedImageOverlay extends StatelessWidget {
  final Future<String> image;
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
      _buildImageWithFutureBuilder(),
      _buildOverlay(),
    ]);
  }

  FutureBuilder<String> _buildImageWithFutureBuilder() {
    return FutureBuilder(
      future: image,
      builder: (BuildContext context, AsyncSnapshot<String> url) {
        if (!url.hasData) {
          return SizedBox(
            height: imageHeight,
            width: imageWidth,
          );
        }

        return Container(
          width: imageWidth,
          height: imageHeight,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: imageBorderRadius,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: _buildImageProvider(url),
            ),
          ),
        );
      },
    );
  }

  ImageProvider _buildImageProvider(AsyncSnapshot<String> url) {
    if (url.data.startsWith(_Constants.startWithAssets)) {
      return AssetImage(url.data);
    } else {
      return NetworkImage(url.data);
    }
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
        child: _buildImage(),
      ),
    );
  }

  _buildImage() {
    if (showOverlayIcon) {
      return Image(
        image: AssetImage(overlayIcon),
        width: overlayIconWidth,
        height: overlayIconHeight,
      );
    }
  }
}
