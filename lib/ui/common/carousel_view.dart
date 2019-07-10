import 'package:flutter/widgets.dart';

class _DefaultConstants {
  static const int _initialPage = 0;
  static const double _viewPortFraction = 0.8;
}

class CarouselView extends StatelessWidget {
  final List<Widget> children;
  final double viewPortFraction;
  final int initialPage;

  const CarouselView({
    @required this.children,
    this.viewPortFraction = _DefaultConstants._viewPortFraction,
    this.initialPage = _DefaultConstants._initialPage,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: children,
      controller: PageController(viewportFraction: viewPortFraction, initialPage: initialPage),
    );
  }
}