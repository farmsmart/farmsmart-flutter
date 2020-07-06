import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:farmsmart_flutter/ui/common/DogTagStyles.dart';
import '../ProfitLossList.dart';

class MockProfitLossListViewModel {
  static ProfitLossListViewModel build() {
    List<ProfitLossListItemViewModel> list = [];
    for(var i = 0; i <= 100; i++) {
      list.add(MockProfitLossListItemViewModel.buildPositive());
    }

    return ProfitLossListViewModel(
        loadingStatus: LoadingStatus.SUCCESS,
        title: _mockTotalCurrency.random(),
        detailText: _mockCurrencyText.random(),
        transactions: list
    );
  }
}

class MockProfitLossHeaderViewModel {
  static ProfitLossHeaderViewModel build() {
    return ProfitLossHeaderViewModel(
      "2,150",
      "KSh",
    );
  }
}

MockString _mockTitleText = MockString(library: [
  "Title example",
  "Longer title example ",
  "A Bit longer title example more longer example"]);

MockString _mockCurrencyText = MockString(library: [
  "Eur",
  "Usd",
  "KSh",
  "RPZ",
  "EUR",
  "USD",
]);

MockString _mockPositiveCurrencyText = MockString(library: ["+255", "0", "+2", "+300", "+450", "+25"]);
MockString _mockNegativeCurrencyText = MockString(library: ["-255", "-50", "-2", "-300", "-450", "-25"]);
MockString _mockTotalCurrency = MockString(library: ["2,150"]);

class MockProfitLossListItemViewModel {
  static ProfitLossListItemViewModel buildPositive() {
    return ProfitLossListItemViewModel(
        title: _mockTitleText.random(),
        subtitle: _mockTitleText.random(),
        detail: _mockPositiveCurrencyText.random(),
        style: DogTagStyles.positiveStyle()
    );
  }

  static ProfitLossListItemViewModel buildNegative() {
    return ProfitLossListItemViewModel(
        title: _mockTitleText.random(),
        subtitle: _mockTitleText.random(),
        detail: _mockNegativeCurrencyText.random(),
        style: DogTagStyles.negativeStyle()
    );
  }
}