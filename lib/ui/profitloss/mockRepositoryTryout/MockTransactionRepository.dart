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