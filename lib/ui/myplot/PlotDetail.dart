import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/ui/article/ArticleDetail.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleListItemViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/ui/common/Alert.dart';
import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:farmsmart_flutter/ui/common/InputAlert.dart';
import 'package:farmsmart_flutter/ui/common/SectionListView.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/common/carousel_view.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/crop/CropDetail.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'PlotDetailHeaderStyle.dart';

class _LocalisedStrings {
  static renameAction() => Intl.message('Rename Crop');

  static cropName() => Intl.message('Crop name');

  static removeAction() => Intl.message('Remove Crop');

  static cancelAction() => Intl.message('Cancel');

  static confirm() => Intl.message('Confirm');

  static remove() => Intl.message('Remove');

  static removeDialogTitle() => Intl.message('Remove crop');

  static removeDialogDescription() => Intl.message(
      'Are you sure you want to remove the crop? All progress will be lost.');

  static viewMore() => Intl.message('Learn more about');
}

class _Constants {
  static const viewportFraction = 0.85;
  static const slideAnimationDurationInSeconds = 1;
}

abstract class PlotDetailStyle {
  final TextStyle titleTextStyle;
  final double stageSectionHeight;
  final EdgeInsets cardPadding;
  final EdgeInsets edgePadding;

  const PlotDetailStyle(this.titleTextStyle, this.stageSectionHeight,
      this.cardPadding, this.edgePadding);
}

class _DefaultStyle implements PlotDetailStyle {
  final TextStyle titleTextStyle = null;
  final double stageSectionHeight = 162;
  final EdgeInsets cardPadding = const EdgeInsets.all(8.0);
  final EdgeInsets edgePadding =
      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0);

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
  int _currentStage = 0;
  PageController _pageController;

  void initState() {
    super.initState();
    final viewModel = widget._viewModelProvider.initial();
    _selectedStage = viewModel.currentStage;
    _pageController = PageController(
      initialPage: viewModel.currentStage,
      viewportFraction: _Constants.viewportFraction,
    );
    _currentStage = viewModel.currentStage;
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

    if (_currentStage != viewModel.currentStage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pageController.animateToPage(
          viewModel.currentStage,
          duration: Duration(seconds: _Constants.slideAnimationDurationInSeconds),
          curve: Curves.ease,
        );
        _currentStage = viewModel.currentStage;
      });
    }

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
      needDivider: false,
    );
    final stages = Container(
      height: widget._style.stageSectionHeight,
      child: CarouselView(
        pageController: _pageController,
        children: _stageCardDataSource(viewModel),
        onPageChange: _pageChanged,
      ),
    );

    widget._articleDetail = ArticleDetail(
      viewModel: articleViewModel,
      articleHeader: Container(),
      articleFooter: _viewCropDetailsButton(context, viewModel),
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
            appBar: _buildAppBar(context, viewModel),
            body: sectionedList,
          );
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

  Widget _viewCropDetailsButton(
      BuildContext context, PlotDetailViewModel viewModel) {
    final buttonViewModel = RoundedButtonViewModel(
        title: _LocalisedStrings.viewMore() + " " + viewModel.title,
        onTap: () {
          _tappedDetail(context: context, provider: viewModel.detailProvider);
        });
    return Padding(
      padding: widget._style.edgePadding,
      child: RoundedButton(
        viewModel: buttonViewModel,
        style: RoundedButtonStyle.actionSheetLargeRoundedButton(),
      ),
    );
  }

  void _moreTapped(ActionSheet sheet) {
    ActionSheet.present(sheet, this.context);
  }

  void _pageChanged(int index) {
    setState(() => _selectedStage = index);
  }

  void _removeAction(PlotDetailViewModel viewModel) {
    Alert.present(
      Alert(
        viewModel: AlertViewModel(
          cancelActionText: _LocalisedStrings.cancelAction(),
          confirmActionText: _LocalisedStrings.remove(),
          titleText: _LocalisedStrings.removeDialogTitle(),
          detailText: _LocalisedStrings.removeDialogDescription(),
          confirmAction: () {
            viewModel.remove();
            Navigator.of(context).pop();
          },
          isDestructive: true,
        ),
      ),
      context,
    );
  }

  void _renameAction(PlotDetailViewModel viewModel) {
    InputAlert.present(_renameInputAlert(viewModel), context);
  }

  InputAlert _renameInputAlert(PlotDetailViewModel viewModel) {
    return InputAlert(
      viewModel: InputAlertViewModel(
          initialValue: viewModel.title,
          cancelActionText: _LocalisedStrings.cancelAction(),
          confirmActionText: _LocalisedStrings.confirm(),
          titleText: _LocalisedStrings.renameAction(),
          hint: _LocalisedStrings.cropName(),
          confirmInputAction: (value) {
            viewModel.rename(value);
          }),
    );
  }

  ActionSheet _moreMenu(PlotDetailViewModel viewModel) {
    final actions = [
      ActionSheetListItemViewModel(
          title: _LocalisedStrings.renameAction(),
          type: ActionType.simple,
          onTap: () => _renameAction(viewModel)),
      ActionSheetListItemViewModel(
          title: _LocalisedStrings.removeAction(),
          type: ActionType.simple,
          isDestructive: true,
          onTap: () => _removeAction(viewModel)),
    ];
    final actionSheetViewModel =
        ActionSheetViewModel(actions, _LocalisedStrings.cancelAction());
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
