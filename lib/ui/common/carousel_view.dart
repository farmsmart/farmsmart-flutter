import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'stage_card.dart';

class CarouselView extends StatefulWidget {
  @override
  _CarouselViewState createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StageCard(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StageCard(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StageCard(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StageCard(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StageCard(),
        ),
      ],
      controller: PageController(viewportFraction: 0.8, initialPage: 0),
    );
    //onPagechanged
  }
}
