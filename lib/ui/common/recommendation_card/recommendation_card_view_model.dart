import 'package:farmsmart_flutter/data/bloc/ViewModelProvider.dart';

class RecommendationCardViewModel {
  Future image;
  String title;
  String subtitle;
  String description;
  String detailActionText;
  String addActionText;
  Function detailAction;
  Function addAction;
  bool isAdded;

  RecommendationCardViewModel({
    this.image,
    this.title,
    this.subtitle,
    this.description,
    this.detailActionText,
    this.addActionText,
    this.detailAction,
    this.addAction,
    this.isAdded = false,
  });
}