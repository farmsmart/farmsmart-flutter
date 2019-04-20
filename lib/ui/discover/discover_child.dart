import 'package:flutter/material.dart';

class HomeDiscoverChild extends StatelessWidget {
  HomeDiscoverChild();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset('assets/raw/articles_mock.png', fit: BoxFit.cover),
    );
  }
}

