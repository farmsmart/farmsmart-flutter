import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/widgets.dart';

class NetworkImageFromFuture extends StatelessWidget {
  final Future<String> futureUrl;
  final double height;
  final double width;

  NetworkImageFromFuture(this.futureUrl, {@required this.height, @required this.width});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureUrl,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return FadeInImage.assetNetwork(
                image: snapshot.data.toString(),
                height: height,
                width: width,
                placeholder: Assets.IMAGE_PLACE_HOLDER,
                fit: BoxFit.fitWidth);
          } else {
            return Container(width: width, height: height,); // placeholder
          }
        }
    );
  }
}