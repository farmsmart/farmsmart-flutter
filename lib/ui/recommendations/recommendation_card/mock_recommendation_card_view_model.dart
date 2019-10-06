import 'dart:math';

import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/PathImageProvider.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/recommendation_card_view_model.dart';

class MockRecommendationCardViewModel {

  static RecommendationCardViewModel buildRandomState() {
    return RecommendationCardViewModel(
      title: _mockTitle.random(),
      subtitle: _mockSubtitle.random(),
      description: _mockLargeStrings.random(),
      detailActionText: 'View Details',
      detailAction: () {},
      addActionText: 'Added',
      addAction: () {},
      imageProvider: PathImageProvider('http://www.freemagebank.com/wp-content/uploads/edd/2015/07/GL0000302LR.jpg'),
      isAdded: Random().nextBool(),
      isHero: Random().nextBool(),
    );
  }

  static RecommendationCardViewModel buildRandomAddToPlotState() {
    return RecommendationCardViewModel(
      title: _mockTitle.random(),
      subtitle: _mockSubtitle.random(),
      description: _mockLargeStrings.random(),
      detailActionText: 'View Details',
      detailAction: () {},
      addActionText: 'Add to Plot',
      addAction: () {},
      imageProvider: PathImageProvider(_mockImageUrl.random()),
    );
  }

  static RecommendationCardViewModel buildRandomAddedToPlotState() {
    return RecommendationCardViewModel(
      title: _mockTitle.random(),
      subtitle: _mockSubtitle.random(),
      description: _mockLargeStrings.random(),
      detailActionText: 'View Details',
      detailAction: () {},
      addActionText: 'Added',
      addAction: () {},
      imageProvider: PathImageProvider('http://www.freemagebank.com/wp-content/uploads/edd/2015/07/GL0000302LR.jpg'),
      isAdded: true,
    );
  }

  static RecommendationCardViewModel buildHardCodedAddToPlotState() {
    return RecommendationCardViewModel(
      title: 'Tomatoes',
      subtitle: '92% match',
      description:
          'Tomatoes are lorem ipsum dolor sit amet consectetur elit sed'
          ' do eiusmod tempor lorem ipsum dolor sit amet',
      detailActionText: 'View Details',
      detailAction: () {},
      addActionText: 'Add to Plot',
      addAction: () {},
      imageProvider: PathImageProvider(_mockImageUrl.random()),
    );
  }

  static RecommendationCardViewModel buildForTestAddToPlotState() {
    return RecommendationCardViewModel(
      title: 'Tomatoes',
      subtitle: '92% match',
      description:
      'Tomatoes are lorem ipsum dolor sit amet consectetur elit sed'
          ' do eiusmod tempor lorem ipsum dolor sit amet',
      detailActionText: 'View Details',
      detailAction: () {},
      addActionText: 'Add to Plot',
      addAction: () {},
      imageProvider:PathImageProvider('assets/raw/placeholder.webp'),
    );
  }

  static RecommendationCardViewModel buildForTestAddedToPlotState() {
    return RecommendationCardViewModel(
      title: 'Tomatoes',
      subtitle: '92% match',
      description:
      'Tomatoes are lorem ipsum dolor sit amet consectetur elit sed'
          ' do eiusmod tempor lorem ipsum dolor sit amet',
      detailActionText: 'View Details',
      detailAction: () {},
      addActionText: 'Added To Plot',
      addAction: () {},
      imageProvider:PathImageProvider('assets/raw/placeholder.webp'),
      isAdded: true,
    );
  }
}


MockString _mockTitle = MockString(library: [
  'Tomatoes',
  'Tomatoes with medium text',
  'Tomatoes with large text to test the limits',
]);

MockString _mockSubtitle = MockString(library: [
  'short subtitle',
  'subtitle with medium text',
  'subtible with large text to test the limits',
]);

MockString _mockLargeStrings = MockString(library: [
  'Large text to test the limits limits limits limits text to test text to test text to test Large text to test the limits',
  'Tomatoes are lorem ipsum dolor sit amet consectetur elit sed do eiusmod tempor elit sed do eiusmod tempor elit sed do eiusmod tempor '
]);

MockString _mockImageUrl = MockString(library: [
  'http://www.freemagebank.com/wp-content/uploads/edd/2015/07/GL0000302LR.jpg',
  'https://www.almanac.com/sites/default/files/styles/primary_image_in_article/public/image_nodes/carrots-table_popidar-ss.jpg?itok=lh-pzqm3',
  'https://cdn1.medicalnewstoday.com/content/images/articles/276/276714/red-and-white-onions.jpg'
]);