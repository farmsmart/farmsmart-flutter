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
      title: _mockTotalCurrency.random(),
      detailText: _mockDetailText.random(),
      subtitle: _mockDetailText.random(),
      transactions: list
    );
  }
}

MockString _mockTitleText = MockString(library: [
  "Title example",
"Longer title example ",
  "A Bit longer title example more longer example"]);

MockString _mockDetailText = MockString(library: [
"Day 490",
"Week 300",
"Day 500000",
"Day 1",
"Day 1",
"A Bit Longer day 9000"
]);

MockString _mockCurrencyText = MockString(library: ["255", "0", "2", "300", "450", "25"]);
MockString _mockTotalCurrency = MockString(library: ["99944,999", "99,99", "00000", "254,360", "92" ]);

class MockProfitLossListItemViewModel {

  static ProfitLossListItemViewModel build() {
    return ProfitLossListItemViewModel(
        title: _mockTitleText.random(),
        subtitle: _mockTitleText.random(),
        detail: _mockCurrencyText.random()
    );
  }
}