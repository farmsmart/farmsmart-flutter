import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/material.dart';

class HomeDiscoverChild extends StatelessWidget {
  HomeDiscoverChild();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(Assets.ARTICLE_MOCK_BACKGROUND, fit: BoxFit.cover),
    );
  }
}

