import 'package:flutter/material.dart';

class HomeProfitLossChild extends StatelessWidget {
  HomeProfitLossChild();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset('assets/raw/profit_mock.png', fit: BoxFit.cover),
    );
  }
}

