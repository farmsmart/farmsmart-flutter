import 'package:farmsmart_flutter/data/model/ImageURLProvider.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleDetailViewModel.dart';

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

  PlotDetailViewModel({String title, 
  String detailText, 
  double progress, 
  ImageURLProvider imageProvider, 
  List<StageCardViewModel> stageCardViewModels, 
  List<ArticleDetailViewModel> stageArticleViewModels, 
  int currentStage, 
  Function rename, 
  Function remove}) : this.title = title, 
  this.detailText = detailText, 
  this.progress = progress, 
  this.imageProvider = imageProvider,
  this.stageCardViewModels = stageCardViewModels,
  this.stageArticleViewModels = stageArticleViewModels, 
  this.currentStage = currentStage,
  this.rename = rename,
  this.remove = remove;
}