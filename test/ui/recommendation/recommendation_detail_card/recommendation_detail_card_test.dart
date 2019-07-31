import 'dart:io';

import 'package:farmsmart_flutter/ui/recommendations/recommendation_detail_card/mock_recommendation_detail_card_view_model.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_detail_card/recommendation_detail_card.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_detail_card/recommendation_detail_card_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Recommendation Detail Card Widget add to plot style',
      (WidgetTester tester) async {
    var recommendationCard = RecommendationDetailCard(
      style: RecommendationDetailCardStyles.build(),
      viewModel: MockRecommendationDetailCardViewModel.buildForTestAddToYourPlot(),
    );

    await tester.pumpWidget(
      MaterialApp(home: recommendationCard),
    );
    await expectLater(
      find.byType(RecommendationDetailCard),
      matchesGoldenFile('recommendation_detail_card_add_to_plot_test.png'),
      skip: Platform.isLinux,
    );
  });

  testWidgets('Recommendation Detail Card Widget added to plot style',
      (WidgetTester tester) async {
    var recommendationCard = RecommendationDetailCard(
      style: RecommendationDetailCardStyles.build(),
      viewModel: MockRecommendationDetailCardViewModel.buildForTestAddedToYourPlot(),
    );

    await tester.pumpWidget(
      MaterialApp(home: recommendationCard),
    );
    await expectLater(
      find.byType(RecommendationDetailCard),
      matchesGoldenFile('recommendation_detail_card_added_to_plot_test.png'),
      skip: Platform.isLinux,
    );
  });
}
