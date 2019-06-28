import 'dart:math';

import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';

import '../ProfitLossList.dart';
import 'MockString.dart';

class MockTransaction {
  static ProfitLossListViewModel build() {
    List<ProfitLossItemViewModel> list = [];
    for(var i = 0; i <= 100; i++) {
        list.add(MockTransactionItem.build());
    }

    return ProfitLossListViewModel(
     loadingStatus: LoadingStatus.SUCCESS,
      title: _mockDetailText.random(),
      detailText: _mockDetailText.random(),
      subtitle: _mockDetailText.random(),
      transactions: list

    );
  }
}

MockString _mockTitleText = MockString(library: ["Title example",
"Longer title example ", "A Bit longer title example more longer example"]);

MockString _mockPlainText = MockString(library: ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."]);

MockString _mockDetailText = MockString(library: ["EUR, DOLLAR, Khz, AUS, ZENY, RUPIE",
"102.00",
"9734,65",
"Completed",
"Planting",
"Day 1",
"A Bit Longer"
]);

class MockTransactionItem {

  static ProfitLossItemViewModel build() {
    final _random = Random();
    final minRange = 0.5;

    return ProfitLossItemViewModel(
        _mockTitleText.random(),
        _mockTitleText.random(),
        _random.nextDouble() - minRange
    );
  }
}