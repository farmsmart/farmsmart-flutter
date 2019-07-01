import 'dart:math';

import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';

import '../ProfitLossList.dart';
import 'MockString.dart';

class MockProfitLossListViewModel {
  static ProfitLossListViewModel build() {
    List<ProfitLossListItemViewModel> list = [];
    for(var i = 0; i <= 100; i++) {
        list.add(MockProfitLossListItemViewModel.build());
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

MockString _mockCurrencyText = MockString(library: ["255", "0", "-2", "300", "-450", "-25"]);

class MockProfitLossListItemViewModel {

  static ProfitLossListItemViewModel build() {
    final _random = Random();
    final minRange = 0.5;

    return ProfitLossListItemViewModel(
        title: _mockTitleText.random(),
        subtitle: _mockTitleText.random(),
        detail: _mockCurrencyText.random()
    );
  }
}