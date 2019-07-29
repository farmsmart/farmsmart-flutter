import 'package:flutter/widgets.dart';

class _DefaultConstants {
  static const int _initialPage = 0;
  static const double _viewPortFraction = 0.85;
}

class CarouselView extends StatelessWidget {
  final List<Widget> _children;
  final double _viewPortFraction;
  final int _initialPage;
  final Function _onPageChange; 

  const CarouselView({
    @required List<Widget> children,
    Function onPageChange,
    double viewPortFraction = _DefaultConstants._viewPortFraction,
    int initialPage = _DefaultConstants._initialPage,
  }) : this._children = children, this._onPageChange = onPageChange, this._viewPortFraction = viewPortFraction, this._initialPage = initialPage;

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: _children,
      onPageChanged: _onPageChange,
      controller: PageController(viewportFraction: _viewPortFraction, initialPage: _initialPage),
    );
  }
}