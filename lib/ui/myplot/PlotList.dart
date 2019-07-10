import 'package:farmsmart_flutter/data/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:flutter/material.dart';
import 'PlotListItem.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';

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

  final String buttonText;
  final String errorButtonText;
  final String errorText;

  final TextStyle titleTextStyle;

  PlotListStyle(
      this.primaryColor,
      this.edgePadding,
      this.titleEdgePadding,
      this.largeButtonEdgePadding,
      this.titleTextStyle,
      this.errorText,
      this.buttonText,
      this.errorButtonText);
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

  final String errorText = "Something went wrong while loading data";
  final String buttonText = "Add Another Crop";
  final String errorButtonText = "Retry";

  const _DefaultStyle();
}

class PlotList extends StatelessWidget {
  final ViewModelProvider<PlotListViewModel> _viewModelProvider;

  const PlotList({Key key, ViewModelProvider<PlotListViewModel> provider}) : this._viewModelProvider = provider, super(key: key);

  @override
  Widget build(BuildContext context,
      {PlotListStyle style = const _DefaultStyle()}) {
    final controller = _viewModelProvider.observe();
    return StreamBuilder<PlotListViewModel>(
        stream: controller.stream,
        initialData: _viewModelProvider.initial(),
        builder: (BuildContext context,
            AsyncSnapshot<PlotListViewModel> snapshot) {
          return _buildBody(context,  snapshot.data, style);
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
            context, viewModel, style); // TODO Check FARM-203
    }
  }

  Widget _buildPage(BuildContext context, PlotListViewModel viewModel,
      PlotListStyle plotStyle, Function goToDetail) {
    return HeaderAndFooterListView.builder(
        itemCount: viewModel.items.length,
        itemBuilder: (BuildContext context, int index) {
          return PlotListItem().buildListItem(viewModel.items[index]);
        },
        physics: ScrollPhysics(),
        shrinkWrap: true,
        header: _buildTitle(viewModel, plotStyle, context: context),
        footer: Padding(
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
        ));
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
    final String retryButton = "Retry";
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AlertDialog(title: Text(plotStyle.errorText), actions: <Widget>[
            FlatButton(child: Text(retryButton), onPressed: viewModel.update)
          ])
        ],
      ),
    );
  }

  //FIXME: Only is built for show that this buttons are not functional yet
  static void _showToast(BuildContext context) {
    final String toastText = "Not Implemented Yet";
    final String toastButtonText = "BACK";
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(toastText),
      action: SnackBarAction(
          label: toastButtonText, onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}
