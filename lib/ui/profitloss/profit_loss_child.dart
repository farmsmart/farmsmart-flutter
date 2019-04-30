import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/material.dart';

class HomeProfitLossChild extends StatelessWidget {
  HomeProfitLossChild();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(Assets.PROFIT_MOCK_BACKGROUND, fit: BoxFit.cover),
    );
  }
}

