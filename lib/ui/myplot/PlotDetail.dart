import 'package:farmsmart_flutter/data/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/data/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:farmsmart_flutter/ui/common/carousel_view.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleDetail.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class PlotDetailStyle {
  final TextStyle titleTextStyle;
  final double stageSectionHeight;
  const PlotDetailStyle(this.titleTextStyle, this.stageSectionHeight);
}

class _DefaultStyle implements PlotDetailStyle {
  final TextStyle titleTextStyle = null;
  final double stageSectionHeight = 162;

  const _DefaultStyle();
}

class PlotDetail extends StatefulWidget {
  final ViewModelProvider<PlotDetailViewModel> _viewModelProvider;
  final PlotDetailStyle _style;

  PlotDetail(
      {Key key,
      ViewModelProvider<PlotDetailViewModel> provider,
      PlotDetailStyle style = const _DefaultStyle()})
      : this._viewModelProvider = provider,
        this._style = style,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlotDetailState();
  }
}

class _PlotDetailState extends State<PlotDetail> {
  int _selectedStage = 0;

  void initState() {
    super.initState();
    final viewModel = widget._viewModelProvider.initial();
    _selectedStage = viewModel.currentStage;
  }

  @override
  Widget build(BuildContext context) {
    final provider = widget._viewModelProvider;
    final controller = provider.observe();
    return StreamBuilder<PlotDetailViewModel>(
        stream: controller.stream,
        initialData: provider.initial(),
        builder: (BuildContext context,
            AsyncSnapshot<PlotDetailViewModel> snapshot) {
          final viewModel = snapshot.data;
          final PlotListItemViewModel headerViewModel = PlotListItemViewModel(
              title: viewModel.title,
              detail: viewModel.detailText,
              progress: viewModel.progress,
              imageProvider: MockImageEntity().build().urlProvider);
          final articleViewModel =
              viewModel.stageArticleViewModels[_selectedStage];
          final header = PlotListItem()
              .buildListItem(viewModel: headerViewModel, onTap: null);
          final stages = Container(
              height: widget._style.stageSectionHeight,
              child: CarouselView(
                children: _stageCardDataSource(viewModel),
                initialPage: _selectedStage,
                onPageChange: _pageChanged,
              ));
          final article = ArticleDetail(viewModel: articleViewModel)
              .buildHeader(context, false);

          return Scaffold(
              appBar: _buildAppBar(context),
              body: ListView(children: <Widget>[header, stages, article]));
        });
  }

  List<Widget> _stageCardDataSource(PlotDetailViewModel viewModel) {
    return viewModel.stageCardViewModels.map((item) {
      return _buildCard(item);
    }).toList();
  }

  Widget _buildCard(StageCardViewModel viewModel) {
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
