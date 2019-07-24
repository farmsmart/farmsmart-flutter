import 'dart:math';

import 'package:farmsmart_flutter/data/model/mock/MockString.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_card/recommendation_card.dart';
import 'package:flutter/material.dart';

class MockRecommendationCardViewModel {

  static RecommendationCardViewModel buildRandomState() {
    return RecommendationCardViewModel(
      title: _mockTitle.random(),
      subtitle: _mockSubtitle.random(),
      description: _mockLargeStrings.random(),
      leftActionText: 'View Details',
      leftAction: () {},
      rightActionText: 'Added',
      rightAction: () {},
      image: NetworkImage('http://www.freemagebank.com/wp-content/uploads/edd/2015/07/GL0000302LR.jpg'),
      isAdded: Random().nextBool(),
      overlayIcon: 'assets/icons/tick_large.png',
    );
  }

  static RecommendationCardViewModel buildRandomAddToPlotState() {
    return RecommendationCardViewModel(
      title: _mockTitle.random(),
      subtitle: _mockSubtitle.random(),
      description: _mockLargeStrings.random(),
      leftActionText: 'View Details',
      leftAction: () {},
      rightActionText: 'Add to Plot',
      rightAction: () {},
      image: NetworkImage(_mockImageUrl.random()),
      overlayIcon: 'assets/icons/tick_large.png',
    );
  }

  static RecommendationCardViewModel buildRandomAddedToPlotState() {
    return RecommendationCardViewModel(
      title: _mockTitle.random(),
      subtitle: _mockSubtitle.random(),
      description: _mockLargeStrings.random(),
      leftActionText: 'View Details',
      leftAction: () {},
      rightActionText: 'Added',
      rightAction: () {},
      image: NetworkImage('http://www.freemagebank.com/wp-content/uploads/edd/2015/07/GL0000302LR.jpg'),
      isAdded: true,
      overlayIcon: 'assets/icons/tick_large.png',
    );
  }

  static RecommendationCardViewModel buildHardCodedAddToPlotState() {
    return RecommendationCardViewModel(
      title: 'Tomatoes',
      subtitle: '92% match',
      description:
          'Tomatoes are lorem ipsum dolor sit amet consectetur elit sed'
          ' do eiusmod tempor lorem ipsum dolor sit amet',
      leftActionText: 'View Details',
      leftAction: () {},
      rightActionText: 'Add to Plot',
      rightAction: () {},
      image: NetworkImage(_mockImageUrl.random()),
      overlayIcon: 'assets/icons/tick_large.png',
    );
  }

  static RecommendationCardViewModel buildForTestAddToPlotState() {
    return RecommendationCardViewModel(
      title: 'Tomatoes',
      subtitle: '92% match',
      description:
      'Tomatoes are lorem ipsum dolor sit amet consectetur elit sed'
          ' do eiusmod tempor lorem ipsum dolor sit amet',
      leftActionText: 'View Details',
      leftAction: () {},
      rightActionText: 'Add to Plot',
      rightAction: () {},
      image: AssetImage('assets/raw/placeholder.webp'),
      overlayIcon: 'assets/icons/tick_large.png',
    );
  }

  static RecommendationCardViewModel buildForTestAddedToPlotState() {
    return RecommendationCardViewModel(
      title: 'Tomatoes',
      subtitle: '92% match',
      description:
      'Tomatoes are lorem ipsum dolor sit amet consectetur elit sed'
          ' do eiusmod tempor lorem ipsum dolor sit amet',
      leftActionText: 'View Details',
      leftAction: () {},
      rightActionText: 'Added To Plot',
      rightAction: () {},
      image: AssetImage('assets/raw/placeholder.webp'),
      overlayIcon: 'assets/icons/tick_large.png',
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