import 'dart:io';

import 'package:farmsmart_flutter/ui/crop/CropInfoListItem.dart';
import 'package:farmsmart_flutter/ui/crop/cropInfoListItem/mockCropInfoListItemStyles.dart';
import 'package:farmsmart_flutter/ui/crop/cropInfoListItemStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Recommendation Detail list item Widget with list of colors',
      (WidgetTester tester) async {
    var recommendationDetailListItem = CropInfoListItem(
      style: RecommendationDetailListItemStyles.build(),
      viewModel: MockRecommendationDetailListItemViewModel.buildForTesting(),
    );

    await tester.pumpWidget(
      MaterialApp(
          home: Directionality(
              textDirection: TextDirection.ltr,
              child: Material(child: recommendationDetailListItem))),
    );
    await expectLater(
      find.byType(CropInfoListItem),
      matchesGoldenFile('cropInfoListItem_test_with_color_list.png'),
      skip: Platform.isLinux,
    );
  });
}
