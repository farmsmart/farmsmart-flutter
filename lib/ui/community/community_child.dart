import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/material.dart';

class HomeCommunityChild extends StatelessWidget {
  HomeCommunityChild();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(Assets.COMMUNITY_MOCK_BACKGROUND, fit: BoxFit.cover),
    );
  }
}

