import 'package:farmsmart_flutter/data/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:farmsmart_flutter/ui/common/carousel_view.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleDetail.dart';
import 'package:farmsmart_flutter/ui/mockData/MockStageCardViewModel.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/playground/styles/stage_card_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlotDetail extends StatefulWidget {
  final PlotDetailViewModel viewModel;

  PlotDetail({Key key, PlotDetailViewModel viewModel}) : this.viewModel = viewModel, super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlotDetailState();
  }
}

class _PlotDetailState extends State<PlotDetail> {
  int _selectedStage = 0;

  final _stageCardDataSource = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: StageCard(
        viewModel: MockStageCardViewModel.buildCompleteState(),
        style: StageCardStyles.buildCompleteStageStyle(),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: StageCard(
        viewModel: MockStageCardViewModel.buildInProgressState(),
        style: StageCardStyles.buildInProgressStageStyle(),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: StageCard(
        viewModel: MockStageCardViewModel.buildUpcomingState(),
        style: StageCardStyles.builtUpcomingStageStyle(),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: StageCard(
        viewModel: MockStageCardViewModel.buildRandom(),
        style: StageCardStyles.builtUpcomingStageStyle(),
      ),
    ),
  ];

  void initState() {
    super.initState();
    _selectedStage = widget.viewModel.currentStage;
  }

  @override
  Widget build(BuildContext context) {
    final PlotListItemViewModel headerViewModel = PlotListItemViewModel(title: widget.viewModel.title, detail: widget.viewModel.detailText, imageProvider: MockImageEntity().build().urlProvider); 
    final articleViewModel =  widget.viewModel.stageArticleViewModels[_selectedStage];      
    final header = PlotListItem().buildListItem(viewModel: headerViewModel, onTap: null);
    final stages = Container(height: 162, child: CarouselView(children: _stageCardDataSource, initialPage: _selectedStage, onPageChange: _pageChanged,));
    final article = ArticleDetail(viewModel: articleViewModel).buildHeader(context, false);

    return Scaffold(
          appBar: _buildAppBar(context),
          body: ListView(children: <Widget>[
      header,
      stages,
      article
    ]));
  }

  Widget _buildAppBar(BuildContext context) {
    return ContextualAppBar(
      shareAction: null,
    ).build(context);
  }

  void _pageChanged(int index) {
      setState(() => _selectedStage = index);
  }
}
