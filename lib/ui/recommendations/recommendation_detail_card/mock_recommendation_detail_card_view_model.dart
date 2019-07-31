import 'package:farmsmart_flutter/model/model/mock/MockString.dart';
import 'package:flutter/widgets.dart';

import 'recommendation_detail_card.dart';

class MockRecommendationDetailCardViewModel {
  static RecommendationDetailCardViewModel buildAddToYourPlotState() {
    return RecommendationDetailCardViewModel(
      title: _mockTitle.random(),
      subtitle: _mockSubtitle.random(),
      action: () {},
      actionText: 'Add To Your Plot',
      isAdded: false,
      image: _mockFutureString(_mockImageUrl.random()),
    );
  }

  static RecommendationDetailCardViewModel buildAddedToYourPlot() {
    return RecommendationDetailCardViewModel(
      title: _mockTitle.random(),
      subtitle: _mockSubtitle.random(),
      action: () {},
      actionText: 'Added To Your Plot',
      isAdded: true,
      image: _mockFutureString(_mockImageUrl.random()),
    );
  }

  static RecommendationDetailCardViewModel buildWithLargeStrings() {
    return RecommendationDetailCardViewModel(
      title: _mockLargeStrings.random(),
      subtitle: _mockLargeStrings.random(),
      action: () {},
      actionText: _mockLargeStrings.random(),
      isAdded: true,
      image: _mockFutureString(_mockImageUrl.random()),
    );
  }

  static RecommendationDetailCardViewModel buildForTestAddedToYourPlot() {
    return RecommendationDetailCardViewModel(
      title: 'Title',
      subtitle: 'Subtitle',
      action: () {},
      actionText: 'Action Text',
      isAdded: true,
      image: _mockFutureString('assets/raw/placeholder.webp'),
    );
  }

  static RecommendationDetailCardViewModel buildForTestAddToYourPlot() {
    return RecommendationDetailCardViewModel(
      title: 'Title',
      subtitle: 'Subtitle',
      action: () {},
      actionText: 'Action Text',
      isAdded: false,
      image: _mockFutureString('assets/raw/placeholder.webp'),
    );
  }
}

Future<String> _mockFutureString(String url) async{
  return url;
}

MockString _mockTitle = MockString(library: [
  "Tomatoes ",
  "Onions",
  "Potatoes",
]);

MockString _mockSubtitle = MockString(library: [
  "94% Match",
  "64% Match",
  "100% Match",
  "55% Match",
  "20% Match",
]);

MockString _mockLargeStrings = MockString(library: [
  "Very large text to test the limits  ",
  "Large text to test ",
]);

MockString _mockImageUrl = MockString(library: [
  'http://www.freemagebank.com/wp-content/uploads/edd/2015/07/GL0000302LR.jpg',
  'https://www.almanac.com/sites/default/files/styles/primary_image_in_article/public/image_nodes/carrots-table_popidar-ss.jpg?itok=lh-pzqm3',
  'https://cdn1.medicalnewstoday.com/content/images/articles/276/276714/red-and-white-onions.jpg'
]);
