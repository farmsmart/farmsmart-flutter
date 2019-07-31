import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/recommendations/RecommentationsList.dart';
import 'package:farmsmart_flutter/ui/recommendations/viewmodel/RecommendationsListViewModel.dart';
import 'package:flutter/material.dart';
import 'PlotDetail.dart';
import 'PlotListItem.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'viewmodel/PlotDetailViewModel.dart';

class PlotListViewModel implements LoadableViewModel, RefreshableViewModel {
  final String title;
  final String buttonTitle;
  final LoadingStatus loadingStatus;
  final List<PlotListItemViewModel> items;
  final Function refresh;
  final ViewModelProvider<RecommendationsListViewModel> recommendationsProvider;
  PlotListViewModel({
    String title,
    String buttonTitle,
    LoadingStatus loadingStatus,
    List<PlotListItemViewModel> items,
    Function refresh,
    ViewModelProvider<RecommendationsListViewModel> recommendationsProvider,
  })  : this.title = title,
        this.loadingStatus = loadingStatus,
        this.buttonTitle = buttonTitle,
        this.items = items,
        this.refresh = refresh,
        this.recommendationsProvider = recommendationsProvider;

}

abstract class PlotListStyle {
  final Color primaryColor;

  final EdgeInsets edgePadding;
  final EdgeInsets titleEdgePadding;
  final EdgeInsets largeButtonEdgePadding;

  final TextStyle titleTextStyle;

  PlotListStyle(
    this.primaryColor,
    this.edgePadding,
    this.titleEdgePadding,
    this.largeButtonEdgePadding,
    this.titleTextStyle,
  );
}

class _DefaultStyle implements PlotListStyle {
  final Color primaryColor = const Color(0xff24d900);

  final EdgeInsets edgePadding = const EdgeInsets.only(top: 20.0);
  final EdgeInsets titleEdgePadding =
      const EdgeInsets.only(left: 32, top: 30, right: 32, bottom: 0);
  final EdgeInsets largeButtonEdgePadding =
      const EdgeInsets.only(left: 32, top: 31, right: 32, bottom: 32);

  final TextStyle titleTextStyle = const TextStyle(
      fontSize: 27, fontWeight: FontWeight.bold, color: Color(0xFF000000));

  const _DefaultStyle();
}

class PlotList extends StatelessWidget {
  final ViewModelProvider<PlotListViewModel> _viewModelProvider;
  final PlotListStyle _style;

  const PlotList(
      {Key key,
      ViewModelProvider<PlotListViewModel> provider,
      PlotListStyle style = const _DefaultStyle()})
      : this._viewModelProvider = provider,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProviderBuilder(provider: _viewModelProvider, successBuilder: _buildPage,);
  }

  Widget _buildPage({BuildContext context, AsyncSnapshot<PlotListViewModel> snapshot}) {
    final viewModel = snapshot.data;
    return HeaderAndFooterListView(
        itemCount: viewModel.items.length,
        itemBuilder: (BuildContext context, int index) {
          final itemViewModel = viewModel.items[index];
          final tapFunction = () => _tappedListItem(
              context: context,
              provider: itemViewModel.detailViewModelProvider);
          return PlotListItem().buildListItem(
              viewModel: viewModel.items[index], onTap: tapFunction);
        },
        physics: ScrollPhysics(),
        shrinkWrap: true,
        headers: [
          _buildTitle(viewModel, _style, context: context)
        ],
        footers: [
          Padding(
            padding: 
            _style.largeButtonEdgePadding,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RoundedButton(
                      viewModel: RoundedButtonViewModel(
                          title: viewModel.buttonTitle,
                          onTap: () => _tappedAdd(
                                context: context,
                                provider: viewModel.recommendationsProvider,
                              )),
                      style: RoundedButtonStyle.largeRoundedButtonStyle()),
                ),
              ],
            ),
          )
        ]);
  }

  Widget _buildTitle(
    PlotListViewModel viewModel,
    PlotListStyle myPlotStyle, {
    BuildContext context,
  }) {
    final String roundedButtonIcon = "assets/icons/profit_add.png";
    return Container(
        padding: myPlotStyle.titleEdgePadding,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      viewModel.title,
                      style: myPlotStyle.titleTextStyle,
                    )
                  ]),
              RoundedButton(
                  viewModel: RoundedButtonViewModel(
                      icon: roundedButtonIcon,
                      onTap: () => _tappedAdd(
                            context: context,
                            provider: viewModel.recommendationsProvider,
                          )),
                  style: RoundedButtonStyle.defaultStyle())
            ]));
  }

  void _tappedAdd({
    BuildContext context,
    ViewModelProvider<RecommendationsListViewModel> provider,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecommendationsList(provider: provider),
      ),
    );
  }

  void _tappedListItem({
    BuildContext context,
    ViewModelProvider<PlotDetailViewModel> provider,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlotDetail(provider: provider),
      ),
    );
  }
}
