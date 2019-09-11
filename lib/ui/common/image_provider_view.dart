import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';
import 'package:farmsmart_flutter/model/repositories/image/ImageRepositoryInterface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _Constants {
  static final placeholderAsset = 'assets/raw/placeholder_color.png';
  static final defaultBorderRadius = BorderRadius.all(Radius.circular(0));
  static final defaultFadeDuration = 200;
}

class ImageProviderView extends StatelessWidget {
  final ImageURLProvider imageURLProvider;
  final double height;
  final double width;
  final BorderRadius imageBorderRadius;

  ImageProviderView({
    this.imageURLProvider,
    this.height,
    this.width,
    this.imageBorderRadius,
  });

  @override
  Widget build(BuildContext context) {

    final cachedURL = imageURLProvider?.cachedUrlToFit(width: width, height: height);
    if (cachedURL !=null) {
      return buildImage(cachedURL);
    }

    return FutureBuilder(
      future: imageURLProvider?.urlToFit(width: width, height: height) ?? Future.value(""),
      builder: (BuildContext context, AsyncSnapshot<String> url) {
        if (!url.hasData || url.data == null) {
          return ClipRRect(
            borderRadius: imageBorderRadius ?? _Constants.defaultBorderRadius,
            child: SizedBox(
              height: height ?? double.infinity,
              width: width ?? double.infinity,
              child: FittedBox(
                child: Image.asset(_Constants.placeholderAsset),
                fit: BoxFit.cover,
              ),
            ),
          );
        }
        return buildImage(url.data);
      },
    );
  }

  buildImage(String url) {
    return ClipRRect(
      borderRadius: imageBorderRadius ?? _Constants.defaultBorderRadius,
      child: SizedBox(
              height: height ?? double.infinity,
              width: width ?? double.infinity, child: CachedNetworkImage(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        fit: BoxFit.cover,
        fadeOutDuration: Duration(milliseconds: _Constants.defaultFadeDuration),
        fadeInDuration: Duration(milliseconds: _Constants.defaultFadeDuration),
        fadeInCurve: Curves.linear,
        fadeOutCurve: Curves.linear,
        placeholder: (context,url) => Image(image:AssetImage(_Constants.placeholderAsset)),
        imageUrl: url,
      ),
    ));
  }
}
