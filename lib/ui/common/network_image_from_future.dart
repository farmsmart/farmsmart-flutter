import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    final placeholder = Container();
    return FutureBuilder(
      future: futureUrl,
      builder: (BuildContext context, AsyncSnapshot<String> url) {
        if (!url.hasData) {
          return SizedBox(
            height: height,
            width: width,
          );
        }

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: imageBorderRadius,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(url.data),
            ),
          ),
        );

        if (!url.hasData) {
          return placeholder;
        }
        return CachedNetworkImage(
          imageUrl: url.data,
          placeholder: (context, url) => placeholder,
          errorWidget: (context, url, error) => placeholder,
        );
      },
    );
  }
}
