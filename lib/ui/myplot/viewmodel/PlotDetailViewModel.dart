import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleDetailViewModel.dart';

class PlotDetailViewModel
{
    final String title;
    final String detailText;
    final double progress;
    final ImageURLProvider imageProvider;
    final List<StageCardViewModel> stageCardViewModels;
    final List<ArticleDetailViewModel> stageArticleViewModels;
    final int currentStage;
    final Function rename;
    final Function remove;
    final ViewModelProvider<CropDetailViewModel> detailProvider;

  PlotDetailViewModel({String title, 
  String detailText, 
  double progress, 
  ImageURLProvider imageProvider, 
  List<StageCardViewModel> stageCardViewModels, 
  List<ArticleDetailViewModel> stageArticleViewModels, 
  int currentStage, 
  Function rename, 
  Function remove,
  ViewModelProvider<CropDetailViewModel> detailProvider,}) : this.title = title, 
  this.detailText = detailText, 
  this.progress = progress, 
  this.imageProvider = imageProvider,
  this.stageCardViewModels = stageCardViewModels,
  this.stageArticleViewModels = stageArticleViewModels, 
  this.currentStage = currentStage,
  this.rename = rename,
  this.remove = remove,
  this.detailProvider = detailProvider;
}