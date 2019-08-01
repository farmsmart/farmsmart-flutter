import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _Constants {
  static final placeholderAsset = 'assets/raw/placeholder.webp';
  static final defaultBorderRadius = BorderRadius.all(Radius.circular(0));
}

class NetworkImageFromFuture extends StatelessWidget {
  final Future<String> futureUrl;
  final double height;
  final double width;
  final BorderRadius imageBorderRadius;

  NetworkImageFromFuture(
    this.futureUrl, {
    this.height,
    this.width = double.infinity,
    this.imageBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureUrl,
      builder: (BuildContext context, AsyncSnapshot<String> url) {
        if (!url.hasData || url.data == null) {
          return SizedBox(
            height: height,
            width: width,
          );
        }
        return buildImage(url.data);
      },
    );
  }

  buildImage(String url) {
    return ClipRRect(
      borderRadius: imageBorderRadius ?? _Constants.defaultBorderRadius,
      child: FadeInImage(
        width: width,
        height: height,
        fit: BoxFit.cover,
        fadeOutDuration: Duration(milliseconds: 200),
        fadeInDuration: Duration(milliseconds: 200),
        fadeInCurve: Curves.linear,
        fadeOutCurve: Curves.linear,
        placeholder: AssetImage(_Constants.placeholderAsset),
        image: NetworkImage(url),
      ),
    );
  }
}
