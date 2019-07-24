import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/MockString.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmount.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountListItem.dart';
import 'package:flutter/material.dart';

class MockRecordAmountViewModel {
  static RecordAmountViewModel buildSale() {
    List<RecordAmountListItemViewModel> list = [];

    for (var i = 0; i < 3; i++) {
      list.add(MockRecordAmountListItemViewModel.build(i));
    }

    return RecordAmountViewModel(
      loadingStatus: LoadingStatus.SUCCESS,
      actions: list,
      buttonTitle: _mockButtonTitle[1],
      listener: (data) => _mockRecordTap(data),
      type: RecordType.sale,
    );
  }

  static RecordAmountViewModel buildCost() {
    List<RecordAmountListItemViewModel> list = [];

    for (var i = 0; i < 3; i++) {
      list.add(MockRecordAmountListItemViewModel.build(i));
    }

    return RecordAmountViewModel(
      loadingStatus: LoadingStatus.SUCCESS,
      actions: list,
      buttonTitle: _mockButtonTitle[0],
      listener: (data) => _mockRecordTap(data),
      type: RecordType.cost,
    );
  }

  static RecordAmountViewModel buildViewSale() {
    List<RecordAmountListItemViewModel> list = [];

    for (var i = 0; i < 3; i++) {
      list.add(MockRecordAmountListItemViewModel.buildNotEditable(i));
    }

    return RecordAmountViewModel(
      loadingStatus: LoadingStatus.SUCCESS,
      actions: list,
      amount: "12.48",
      buttonTitle: _mockButtonTitle[1],
      type: RecordType.sale,
      isEditable: false,
    );
  }

  static RecordAmountViewModel buildViewCost() {
    List<RecordAmountListItemViewModel> list = [];

    for (var i = 0; i < 3; i++) {
      list.add(MockRecordAmountListItemViewModel.buildNotEditable(i));
    }

    return RecordAmountViewModel(
      loadingStatus: LoadingStatus.SUCCESS,
      actions: list,
      buttonTitle: _mockButtonTitle[1],
      type: RecordType.cost,
      isEditable: false,
      amount: "-233.3",
    );
  }

  static _mockRecordTap(RecordData save) {
    print(
      "You recorded:\nAMOUNT: " +
          save.amount +
          "\nDATE: " +
          save.date.toIso8601String() +
          "\nCROP: " +
          save.crop +
          "\nDESC: " +
          save.description,
    );
  }
}

class MockRecordAmountListItemViewModel {
  static RecordAmountListItemViewModel build(int index) {
    return RecordAmountListItemViewModel(
      type: _cellType[index],
      selectedDate: _mockSelectedDate[index],
      listOfCrops: _mockListOfCrops[index],
    );
  }

  static RecordAmountListItemViewModel buildNotEditable(int index) {
    return RecordAmountListItemViewModel(
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
