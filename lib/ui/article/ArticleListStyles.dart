import 'package:flutter/material.dart';

import 'ArticleList.dart';

class ArticleListStyles {
  static ArticleListStyle buildForCommunity() =>
      buildForDiscover().copyWith(heroEnabled: false);

  static ArticleListStyle buildForDiscover() {
    return ArticleListStyle(
      titleTextStyle: TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1a1b46),
      ),
      titleEdgePadding: EdgeInsets.only(
        left: 34.0,
        right: 34.0,
        top: 35.0,
        bottom: 30.0,
      ),
      heroEnabled: true,
    );
  }
}
