import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransaction.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionListItem.dart';

class MockRecordTransactionViewModel {
  static RecordTransactionViewModel buildSaleTransaction() {
    List<RecordTransactionListItemViewModel> list = [];

    for (var i = 0; i < 3; i++) {
      list.add(MockRecordTransactionListItemViewModel.build(i));
    }

    return RecordTransactionViewModel(
      actions: list,
      buttonTitle: _mockButtonTitle[1],
      recordTransaction: (data) => _mockRecordTap(data),
      type: TransactionType.sale,
    );
  }

  static RecordTransactionViewModel buildCostTransaction() {
    List<RecordTransactionListItemViewModel> list = [];

    for (var i = 0; i < 3; i++) {
      list.add(MockRecordTransactionListItemViewModel.build(i));
    }

    return RecordTransactionViewModel(
      actions: list,
      buttonTitle: _mockButtonTitle[0],
      recordTransaction: (data) => _mockRecordTap(data),
      type: TransactionType.cost,
    );
  }

  static RecordTransactionViewModel buildViewSale() {
    List<RecordTransactionListItemViewModel> list = [];

    for (var i = 0; i < 3; i++) {
      list.add(MockRecordTransactionListItemViewModel.buildNotEditable(i));
    }

    return RecordTransactionViewModel(
      actions: list,
      amount: "12.48",
      buttonTitle: _mockButtonTitle[1],
      type: TransactionType.sale,
      isEditable: false,
    );
  }

  static RecordTransactionViewModel buildViewCost() {
    List<RecordTransactionListItemViewModel> list = [];

    for (var i = 0; i < 3; i++) {
      list.add(MockRecordTransactionListItemViewModel.buildNotEditable(i));
    }

    return RecordTransactionViewModel(
      actions: list,
      buttonTitle: _mockButtonTitle[1],
      type: TransactionType.cost,
      isEditable: false,
      amount: "-233.3",
    );
  }

  static _mockRecordTap(RecordTransactionData save) {
    print(
      "You recorded:\nAMOUNT: " +
          save.amount +
          "\nDATE: " +
          save.date.toIso8601String() +
          "\nCROP: " +
          save.crop
    );

    if (save.description != null) {
      print("DESC: "+ save.description);
    }
  }
}

class MockRecordTransactionListItemViewModel {
  static RecordTransactionListItemViewModel build(int index) {
    return RecordTransactionListItemViewModel(
      type: _cellType[index],
      selectedDate: _mockSelectedDate[index],
      listOfCrops: _mockListOfCrops[index],
    );
  }

  static RecordTransactionListItemViewModel buildNotEditable(int index) {
    return RecordTransactionListItemViewModel(
      description: _mockDescription.random(),
      selectedDate: _mockSelectedDate[index],
      listOfCrops: _mockListOfCrops[index],
      selectedItem: _mockCrop[index],
      isEditable: false,
    );
  }
}

List _cellType = [
  RecordCellType.pickDate,
  RecordCellType.pickItem,
  RecordCellType.description,
];

List _mockCrop = [
  "Okra",
  "Tomatoes",
  "Potatoes",
  "Cowpeas",
  "Sweetcorn",
  "Cucumber",
  "Beetroot",
];

List _mockSelectedDate = [
  DateTime.now(),
  null,
  null,
];

List _mockButtonTitle = [
  "Record Cost",
  "Record Sale",
];

MockString _mockDescription = MockString(library: [
  "Add another description",
  "This is a description a bit longer",
  "A longer description to test if multiline it's working well",
  "One more bigger title"
]);

List _mockListOfCrops = [
  null,
  [
    "Okra",
    "Tomatoes",
    "Potatoes",
    "Cowpeas",
    "Sweetcorn",
    "Cucumber",
    "Beetroot"
  ],
  null
];
