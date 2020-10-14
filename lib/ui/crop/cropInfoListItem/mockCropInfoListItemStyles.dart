import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:flutter/material.dart';

import '../CropInfoListItem.dart';

class MockRecommendationDetailListItemViewModel {

  static CropInfoListItemViewModel buildWithoutColorList() =>
      CropInfoListItemViewModel(
        iconPath: _mockIcons.random(),
        title: _mockTitle.random(),
        subtitle: _mockSubtitle.random(),
      );

  static CropInfoListItemViewModel buildWithLargeColorList() =>
      CropInfoListItemViewModel(
        iconPath: _mockIcons.random(),
        title: _mockTitle.random(),
        subtitle: _mockSubtitle.random(),
        colors: _mockLargeListOfColors,
      );

  static CropInfoListItemViewModel buildWithLargeTextAndColorList() =>
      CropInfoListItemViewModel(
        iconPath: _mockIcons.random(),
        title: _mockLargeStrings.random(),
        subtitle: _mockLargeStrings.random(),
        colors: _mockLargeListOfColors,
      );

  static CropInfoListItemViewModel buildWithShortColorList() =>
      CropInfoListItemViewModel(
        iconPath: _mockIcons.random(),
        title: _mockTitle.random(),
        subtitle: _mockSubtitle.random(),
        colors: _mockShortListOfColors,
      );

  static CropInfoListItemViewModel buildForTesting() =>
      CropInfoListItemViewModel(
        iconPath: 'assets/icons/detail_icon_best_soil.png',
        title: 'Best Soil',
        subtitle: 'Sandy, Black Cotton, Loamy',
        colors: _mockShortListOfColors,
      );
}

List<Color> _mockShortListOfColors = [
  Color(0xffeac153),
  Color(0xffb3762e),
  Color(0xff42434d)
];

List<Color> _mockLargeListOfColors = [
  Color(0xffeac153),
  Color(0xffb3762e),
  Color(0xfff28282),
  Color(0xfff00000),
  Color(0xffb20000),
  Color(0xff22434d),
  Color(0xff92434d),
  Color(0xff42434d),
  Color(0xff62434d),
  Color(0xff92434d),
  Color(0xffeac153),
  Color(0xffb3762e),
  Color(0xfff28282),
  Color(0xfff00000),
  Color(0xffb20000),
  Color(0xff22434d),

];

MockString _mockLargeStrings = MockString(library: [
  'Very large text to test the limits and see how it looks ',
  'Large text to test how it looks',
]);

MockString _mockIcons = MockString(library: [
  'assets/icons/detail_icon_best_soil.png',
  'assets/icons/detail_icon_companion.png',
  'assets/icons/detail_icon_complexity.png',
  'assets/icons/detail_icon_non_companion.png',
  'assets/icons/detail_icon_crop_type.png',
  'assets/icons/detail_icon_water.png',
  'assets/icons/detail_icon_setup_costs.png',
]);

MockString _mockTitle = MockString(library: [
  'Best Soil',
  'Complexity',
  'Crop Type',
  'Water Frequency',
]);

MockString _mockSubtitle = MockString(library: [
  'Sandy, Black Cotton, Loamy',
  'Intermediate',
  'Eggplant, Capsicum, Chillies, Tobacco',
  'Potatoes, Okra',
]);