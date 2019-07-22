
import 'dart:math';

import 'package:farmsmart_flutter/ui/profile/UserProfile.dart';
import 'package:farmsmart_flutter/ui/profitloss/mockRepositoryTryout/MockString.dart';

class MockUserProfileViewModel {
  static UserProfileViewModel build() {
    return UserProfileViewModel(
      userName: _mockUserName.random(),
      activeCrops: Random().nextInt(50),
      completedCrops: Random().nextInt(50),
      picture: "",
      buttonTitle: "",
      //imageUrl: "https://firebasestorage.googleapis.com/v0/b/farmsmart-20190415.appspot.com/o/flamelink%2Fmedia%2FLxHKKHJPSN3Atvbx1nv3_Cucumber.jpg?alt=media&token=642bb3b7-ac3d-4a6d-8b73-fbebd5c03eaa"
    );
  }
}


MockString _mockUserName = MockString(library: [
  "Ireti Kuta",
  "Longer User Name",
  "A bit Longer User Name",
  "Super extra large User Name"
]);