import 'dart:io';

import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/mock_recommendation_card_view_model.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_compact_card/recommendation_compact_card.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_compact_card/recommendation_compact_card_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Recommendation Compact Card Widget add to plot style',
      (WidgetTester tester) async {
    var recommendationCard = RecommendationCompactCard(
      style: RecommendationCompactCardStyles.build(),
      viewModel: MockRecommendationCardViewModel.buildForTestAddToPlotState(),
    );

    await tester.pumpWidget(
      MaterialApp(home: recommendationCard),
    );
    await expectLater(
      find.byType(RecommendationCompactCard),
      matchesGoldenFile('recommendation_compact_card_add_to_plot_test.png'),
      skip: Platform.isLinux,
    );
  });

  testWidgets('Recommendation compact Card Widget added to plot style',
      (WidgetTester tester) async {
    var recommendationCard = RecommendationCompactCard(
      style: RecommendationCompactCardStyles.build(),
      viewModel: MockRecommendationCardViewModel.buildForTestAddedToPlotState(),
    );

    await tester.pumpWidget(
      MaterialApp(home: recommendationCard),
    );
    await expectLater(
      find.byType(RecommendationCompactCard),
      matchesGoldenFile('recommendation_compact_card_added_to_plot_test.png'),
      skip: Platform.isLinux,
    );
  });
}
