import 'dart:io';

import 'package:farmsmart_flutter/ui/recommendations/recommendation_detail_listitem/mock_recommendation_detail_listitem_view_model.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_detail_listitem/recommendation_detail_listitem.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_detail_listitem/recommendation_detail_listitem_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Recommendation Detail list item Widget with list of colors',
      (WidgetTester tester) async {
    var recommendationDetailListItem = RecommendationDetailListItem(
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
      find.byType(RecommendationDetailListItem),
      matchesGoldenFile('recommendation_detail_listitem_with_color_list.png'),
      skip: Platform.isLinux,
    );
  });
}
