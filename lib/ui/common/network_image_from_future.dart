import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NetworkImageFromFuture extends StatelessWidget {
  final Future<String> futureUrl;
  final double height;
  final double width;
  final BoxFit fit;

  NetworkImageFromFuture(this.futureUrl, {this.height, this.width, this.fit});

  @override
  Widget build(BuildContext context) {
    final placeholder = Image.asset(Assets.IMAGE_PLACE_HOLDER);
    return SizedBox(width:width, height: height,
      child: FittedBox(
        fit: fit,
        child: FutureBuilder(
            future: futureUrl,
            builder: (BuildContext context, AsyncSnapshot<String> url) {
                if (!url.hasData) {
                  return placeholder;
                }
                return CachedNetworkImage(
            imageUrl: url.data,
            placeholder: (context, url) =>  placeholder,
            errorWidget: (context, url, error) => placeholder,);
            }),
      ),
    );
  }
        // ...
}