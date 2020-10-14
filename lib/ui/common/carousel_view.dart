import 'package:flutter/widgets.dart';

class CarouselView extends StatelessWidget {
  final List<Widget> _children;
  final Function _onPageChange;
  final PageController _pageController;

  const CarouselView({
    @required List<Widget> children,
    Function onPageChange,
    @required PageController pageController,
  })
      : this._children = children,
        this._onPageChange = onPageChange,
        this._pageController = pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: _children,
      onPageChanged: _onPageChange,
      controller: _pageController,
    );
  }
}