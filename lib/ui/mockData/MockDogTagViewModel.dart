import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:farmsmart_flutter/ui/common/Dogtag.dart';


class MockDogTagViewModel {
  static DogTagViewModel buildWithText() {
    return DogTagViewModel(
      title: _mockString.random(),
    );
  }
  static DogTagViewModel buildWithPositiveNumber() {
    return DogTagViewModel(
      number: _mockPositiveNumber.random()
    );
  }
  static DogTagViewModel buildWithNegativeNumber() {
    return DogTagViewModel(
      number: _mockNegativeNumber.random(),
    );
  }
}

MockString _mockString = MockString(library: [
  "Day 1",
  "Day 15",
  "Day 50",
  "Day 500",
  "Day 1000"
]);

MockString _mockPositiveNumber = MockString(library: [
  "50",
  "450",
  "4500",
  "90000"
]);

MockString _mockNegativeNumber = MockString(library: [
  "-50",
  "-450",
  "-4500",
  "-90000"
]);