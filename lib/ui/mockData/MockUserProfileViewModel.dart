import 'dart:math';

import 'package:farmsmart_flutter/ui/profile/UserProfile.dart';
import 'package:farmsmart_flutter/ui/profitloss/mockRepositoryTryout/MockString.dart';
import 'package:flutter/material.dart';

class MockUserProfileViewModel {
  static UserProfileViewModel build() {
    return UserProfileViewModel(
      userName: _mockUserName.random(),
      activeCrops: Random().nextInt(50),
      completedCrops: Random().nextInt(50),
      image: NetworkImage(_mockImage.random()),
      buttonTitle: "",
    );
  }
}

MockString _mockImage = MockString(library: [
  "https://occ-0-1722-1723.1.nflxso.net/art/d2938/a54bf5710e24e03aed993f1597454a46699d2938.jpg",
  "https://www.flower-pepper.com/wp-content/uploads/2016/10/Kermit-the-Frog-by-Bartholomew-300x378.jpg",
  "https://vignette.wikia.nocookie.net/rugratseries/images/1/1a/Tommy.jpg/revision/latest?cb=20110202050218",
]);

MockString _mockUserName = MockString(library: [
  "Mininame"
      "Ireti Kuta",
  "Longer User Name",
  "A bit Longer User Name",
  "Super extra large User Name"
]);
