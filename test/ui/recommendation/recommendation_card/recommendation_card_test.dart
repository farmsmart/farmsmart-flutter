import 'dart:io';

import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/mock_recommendation_card_view_model.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/recommendation_card.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/recommendation_card_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Recommendation Card Widget add to plot style',
      (WidgetTester tester) async {
    var recommendationCard = RecommendationCard(
      style: RecommendationCardStyles.buildStyle(),
      viewModel: MockRecommendationCardViewModel.buildForTestAddToPlotState(),
    );

    await tester.pumpWidget(
      MaterialApp(home: recommendationCard),
    );
    await expectLater(
      find.byType(RecommendationCard),
      matchesGoldenFile('recommendation_card_add_to_plot_test.png'),
      skip: Platform.isLinux,
    );
  });

  testWidgets('Recommendation Card Widget added to plot style',
      (WidgetTester tester) async {
    var recommendationCard = RecommendationCard(
      style: RecommendationCardStyles.buildStyle(),
      viewModel: MockRecommendationCardViewModel.buildForTestAddedToPlotState(),
    );

    await tester.pumpWidget(
      MaterialApp(home: recommendationCard),
    );
    await expectLater(
      find.byType(RecommendationCard),
      matchesGoldenFile('recommendation_card_added_to_plot_test.png'),
      skip: Platform.isLinux,
    );
  });
}
