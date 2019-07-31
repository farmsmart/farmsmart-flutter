import 'package:farmsmart_flutter/data/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';

import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:farmsmart_flutter/ui/common/SectionListView.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/common/carousel_view.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/crop/CropDetail.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleDetail.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleListItemViewModel.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'PlotDetailHeaderStyle.dart';

class _Strings {
  static final renameAction = "Rename Crop";
  static final removeAction = "Delete Crop";
  static final cancelAction = "Cancel";
}

abstract class PlotDetailStyle {
  final TextStyle titleTextStyle;
  final double stageSectionHeight;
  final EdgeInsets cardPadding;
  const PlotDetailStyle(
      this.titleTextStyle, this.stageSectionHeight, this.cardPadding);
}

class _DefaultStyle implements PlotDetailStyle {
  final TextStyle titleTextStyle = null;
  final double stageSectionHeight = 162;
  final EdgeInsets cardPadding = const EdgeInsets.all(8.0);
  const _DefaultStyle();
}

class PlotDetail extends StatefulWidget {
  final ViewModelProvider<PlotDetailViewModel> _viewModelProvider;
  final PlotDetailStyle _style;
  ArticleDetail _articleDetail;
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
    return ViewModelProviderBuilder(
      provider: widget._viewModelProvider,
      successBuilder: _successBuilder,
    );
  }

  Widget _successBuilder(
      {BuildContext context, AsyncSnapshot<PlotDetailViewModel> snapshot}) {
    final viewModel = snapshot.data;
    final PlotListItemViewModel headerViewModel = PlotListItemViewModel(
        title: viewModel.title,
        detail: viewModel.detailText,
        progress: viewModel.progress,
        imageProvider: viewModel.imageProvider);
    final articleViewModel = viewModel.stageArticleViewModels[_selectedStage];
    final header = PlotListItem().buildListItem(
      viewModel: headerViewModel,
      itemStyle: PlotDetailHeaderStyle(),
      onTap: () => _tappedDetail(
        context: context,
        provider: viewModel.detailProvider,
      ),
    );
    final stages = Container(
        height: widget._style.stageSectionHeight,
        child: CarouselView(
          children: _stageCardDataSource(viewModel),
          initialPage: _selectedStage,
          onPageChange: _pageChanged,
        ));

    widget._articleDetail = ArticleDetail(
      viewModel: articleViewModel,
      articleHeader: Container(),
    );
    final topSection = HeaderAndFooterListView(
      headers: <Widget>[header, stages],
    );

    return FutureBuilder(
        future: widget._articleDetail.fetchReleated(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ArticleListItemViewModel>> relatedArticles) {
          final sectionedList = SectionedListView(
            sections: [topSection, widget._articleDetail],
          );
          return Scaffold(
              appBar: _buildAppBar(context, viewModel), body: sectionedList);
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

  Widget _buildAppBar(BuildContext context, PlotDetailViewModel viewModel) {
    return ContextualAppBar(
      moreAction: () => _moreTapped(_moreMenu(viewModel)),
    ).build(context);
  }

  void _moreTapped(ActionSheet sheet) {
    ActionSheet.present(sheet, this.context);
  }

  void _pageChanged(int index) {
    setState(() => _selectedStage = index);
  }

  void _removeAction(PlotDetailViewModel viewModel) {
    viewModel.remove(); //TODO: add the confirm when ready
    Navigator.of(context).pop();
  }

  void _renameAction(PlotDetailViewModel viewModel) {
    viewModel.rename("test"); //TODO: add the UI for input when ready
  }

  ActionSheet _moreMenu(PlotDetailViewModel viewModel) {
    final actions = [
      ActionSheetListItemViewModel(
          title: Intl.message(_Strings.renameAction),
          type: ActionType.simple,
          onTap: () => _renameAction(viewModel)),
      ActionSheetListItemViewModel(
          title: Intl.message(_Strings.removeAction),
          type: ActionType.simple,
          isDestructive: true,
          onTap: () => _removeAction(viewModel)),
    ];
    final actionSheetViewModel =
        ActionSheetViewModel(actions, Intl.message(_Strings.cancelAction));
    return ActionSheet(
        viewModel: actionSheetViewModel,
        style: ActionSheetStyle.defaultStyle());
  }

  void _tappedDetail({
    BuildContext context,
    ViewModelProvider<CropDetailViewModel> provider,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CropDetail(provider: provider),
      ),
    );
  }
}
