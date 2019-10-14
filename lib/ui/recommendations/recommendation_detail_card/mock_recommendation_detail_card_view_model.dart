import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/PathImageProvider.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/recommendation_card_view_model.dart';


class MockRecommendationDetailCardViewModel {
  static RecommendationCardViewModel buildAddToYourPlotState() {
    return RecommendationCardViewModel(
      title: _mockTitle.random(),
      subtitle: _mockSubtitle.random(),
      addAction: () {},
      addActionText: 'Add To Your Plot',
      isAdded: false,
      imageProvider: PathImageProvider(_mockImageUrl.random()),
    );
  }

  static RecommendationCardViewModel buildAddedToYourPlot() {
    return RecommendationCardViewModel(
      title: _mockTitle.random(),
      subtitle: _mockSubtitle.random(),
      addAction: () {},
      addActionText: 'Added To Your Plot',
      isAdded: true,
      imageProvider: PathImageProvider(_mockImageUrl.random()),
    );
  }

  static RecommendationCardViewModel buildWithLargeStrings() {
    return RecommendationCardViewModel(
      title: _mockLargeStrings.random(),
      subtitle: _mockLargeStrings.random(),
      addAction: () {},
      addActionText: _mockLargeStrings.random(),
      isAdded: true,
      imageProvider: PathImageProvider(_mockImageUrl.random()),
    );
  }

  static RecommendationCardViewModel buildForTestAddedToYourPlot() {
    return RecommendationCardViewModel(
      title: 'Title',
      subtitle: 'Subtitle',
      addAction: () {},
      addActionText: 'Action Text',
      isAdded: true,
      imageProvider: PathImageProvider('assets/raw/placeholder.webp'),
    );
  }

  static RecommendationCardViewModel buildForTestAddToYourPlot() {
    return RecommendationCardViewModel(
      title: 'Title',
      subtitle: 'Subtitle',
      addAction: () {},
      addActionText: 'Action Text',
      isAdded: false,
      imageProvider: PathImageProvider('assets/raw/placeholder.webp'),
    );
  }
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
