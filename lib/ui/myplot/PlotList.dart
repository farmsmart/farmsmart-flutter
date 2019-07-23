import 'package:farmsmart_flutter/data/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/ErrorRetry.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:flutter/material.dart';
import 'PlotDetail.dart';
import 'PlotListItem.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:intl/intl.dart';
import 'viewmodel/PlotDetailViewModel.dart';

class _Strings {
  static String loadingError = "Oops, there was a problem!";
  static String retryAction = "Retry";
}

class PlotListViewModel {
  final String title;
  final String buttonTitle;
  final LoadingStatus status;
  final List<PlotListItemViewModel> items;
  final Function  update;
  final Function  add;
  PlotListViewModel({String title, String buttonTitle, LoadingStatus status, List<PlotListItemViewModel> items, Function update, Function add}) : this.title = title, this.status = status, this.buttonTitle = buttonTitle, this.items = items, this.update = update, this.add = add;
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
      this.titleTextStyle);
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

  const PlotList({Key key, ViewModelProvider<PlotListViewModel> provider, PlotListStyle style = const _DefaultStyle()}) : this._viewModelProvider = provider,  this._style = style, super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = _viewModelProvider.observe();
    return StreamBuilder<PlotListViewModel>(
        stream: controller.stream,
        initialData: _viewModelProvider.initial(),
        builder: (BuildContext context,
            AsyncSnapshot<PlotListViewModel> snapshot) {
          return _buildBody(context,  snapshot.data, _style);
        });
  }

  Widget _buildBody(BuildContext context, PlotListViewModel viewModel,
      PlotListStyle style) {
            final status =
        (viewModel == null) ? LoadingStatus.LOADING : viewModel.status;
    switch (status) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildPage(
            context, viewModel, style, null);
      case LoadingStatus.ERROR:
        return _buildErrorPage(
            context, viewModel, style);
    }
  }

  Widget _buildPage(BuildContext context, PlotListViewModel viewModel,
      PlotListStyle plotStyle, Function goToDetail) {
       
    return HeaderAndFooterListView(
        itemCount: viewModel.items.length,
        itemBuilder: (BuildContext context, int index) {
           final itemViewModel = viewModel.items[index];
           final tapFunction = () => _tappedListItem(
          context: context, provider: itemViewModel.detailViewModelProvider);
          return PlotListItem().buildListItem(viewModel: viewModel.items[index], onTap: tapFunction);
        },
        physics: ScrollPhysics(),
        shrinkWrap: true,
        headers: [_buildTitle(viewModel, plotStyle, context: context)],
        footers: [Padding(
          padding: plotStyle.largeButtonEdgePadding,
          child: Row(
            children: <Widget>[
              Expanded(
                child: RoundedButton(
                    viewModel: RoundedButtonViewModel(
                        title: viewModel.buttonTitle,
                        onTap: () => viewModel.add() ),
                    style: RoundedButtonStyle.largeRoundedButtonStyle()),
              ),
            ],
          ),
        )]);
  }

  Widget _buildTitle(PlotListViewModel viewModel, PlotListStyle myPlotStyle,
      {BuildContext context}) {
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
                      onTap: () => viewModel.add()),
                  style: RoundedButtonStyle.defaultStyle())
            ]));
  }

  Widget _buildErrorPage(BuildContext context, PlotListViewModel viewModel,
      PlotListStyle plotStyle) {
    return ErrorRetry(errorMessage: Intl.message(_Strings.loadingError), retryActionLabel: Intl.message(_Strings.retryAction), retryFunction: viewModel.update);
  }

    void _tappedListItem(
      {BuildContext context, ViewModelProvider<PlotDetailViewModel> provider}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlotDetail(provider: provider),
      ),
    );
  }

}
