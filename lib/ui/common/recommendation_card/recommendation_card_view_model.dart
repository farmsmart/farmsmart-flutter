import 'package:farmsmart_flutter/data/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';

class RecommendationCardViewModel {
  Future image;
  String title;
  String subtitle;
  String description;
  String detailActionText;
  String addActionText;
  double score;
  ViewModelProvider<CropDetailViewModel> detailProvider;
  Function detailAction;
  Function addAction;
  bool isAdded;
  bool isHero;

  RecommendationCardViewModel({
    this.image,
    this.title,
    this.subtitle,
    this.description,
    this.detailActionText,
    this.addActionText,
    this.score,
    this.detailProvider,
    this.detailAction,
    this.addAction,
    this.isAdded = false,
    this.isHero = false,
  });
}