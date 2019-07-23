
import 'dart:math';

import 'package:farmsmart_flutter/ui/profile/UserProfile.dart';
import 'package:farmsmart_flutter/ui/profitloss/mockRepositoryTryout/MockString.dart';

class MockUserProfileViewModel {
  static UserProfileViewModel build() {
    return UserProfileViewModel(
      userName: _mockUserName.random(),
      activeCrops: Random().nextInt(50),
      completedCrops: Random().nextInt(50),
      buttonTitle: "",
    );
  }
}


MockString _mockUserName = MockString(library: [
  "Mininame"
  "Ireti Kuta",
  "Longer User Name",
  "A bit Longer User Name",
  "Super extra large User Name"
]);