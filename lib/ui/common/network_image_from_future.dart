import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NetworkImageFromFuture extends StatelessWidget {
  final Future<String> futureUrl;
  final double height;
  final double width;
  final BoxFit fit;

  NetworkImageFromFuture(this.futureUrl, {@required this.height, @required this.width, this.fit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width:width, height: height,
      child: FittedBox(
        fit: fit,
        child: FutureBuilder(
            future: futureUrl,
            builder: (BuildContext context, AsyncSnapshot<String> url) {
              final placeholder = Image.asset(Assets.IMAGE_PLACE_HOLDER);
                if (!url.hasData) {
                  return placeholder;
                }
                return CachedNetworkImage(
            imageUrl: url.data,
            placeholder: (context, url) =>  CircularProgressIndicator(),
            errorWidget: (context, url, error) => Text(error.toString()),);
            }),
      ),
    );
  }
        // ...
}