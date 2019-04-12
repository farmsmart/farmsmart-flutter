import 'package:flutter/material.dart';

class HomeArticlesChild extends StatelessWidget {
  HomeArticlesChild();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset('assets/raw/articles_mock.png', fit: BoxFit.cover),
    );
  }
}

