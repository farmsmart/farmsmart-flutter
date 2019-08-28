import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';

class RecommendationCardViewModel {
  ImageURLProvider imageProvider;
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
    this.imageProvider,
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