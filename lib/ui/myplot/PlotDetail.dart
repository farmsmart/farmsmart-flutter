import 'package:farmsmart_flutter/data/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:farmsmart_flutter/ui/common/carousel_view.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleDetail.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';
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

  void initState() {
    super.initState();
    _selectedStage = widget.viewModel.currentStage;
  }

  @override
  Widget build(BuildContext context) {
    final PlotListItemViewModel headerViewModel = PlotListItemViewModel(title: widget.viewModel.title, detail: widget.viewModel.detailText, imageProvider: MockImageEntity().build().urlProvider); 
    final articleViewModel =  widget.viewModel.stageArticleViewModels[_selectedStage];      
    final header = PlotListItem().buildListItem(viewModel: headerViewModel, onTap: null);
    final stages = Container(height: 162, child: CarouselView(children: _stageCardDataSource(), initialPage: _selectedStage, onPageChange: _pageChanged,));
    final article = ArticleDetail(viewModel: articleViewModel).buildHeader(context, false);

    return Scaffold(
          appBar: _buildAppBar(context),
          body: ListView(children: <Widget>[
      header,
      stages,
      article
    ]));
  }

  List<Widget> _stageCardDataSource(){
    return widget.viewModel.stageCardViewModels.map((item) {
        return _buildCard(item);
    }).toList();
  }

  Widget _buildCard(StageCardViewModel viewModel){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StageCard(
        viewModel: viewModel,
        style: viewModel.style,
      ),
    );
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
