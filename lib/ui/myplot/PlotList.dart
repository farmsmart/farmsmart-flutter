import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'myplot_viewmodel.dart';
import 'PlotListItem.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';


class PlotListViewModel {
  final String title;

  final String buttonTitle;

  PlotListViewModel(this.title, this.buttonTitle);
}

PlotListViewModel buildPlotListViewModel() {
  return PlotListViewModel(Strings.myPlotTab, "Add Another Crop");
}

abstract class PlotListStyle {

  final Color primaryColor;

  final EdgeInsets edgePadding;
  final EdgeInsets titleEdgePadding;

  final String buttonText;
  final String errorButtonText;
  final String errorText;

  final TextStyle titleTextStyle;

  PlotListStyle(this.primaryColor, this.edgePadding, this.titleEdgePadding,
      this.titleTextStyle, this.errorText, this.buttonText, this.errorButtonText);
}

class _DefaultStyle implements PlotListStyle {

  final Color primaryColor =  const Color(0xff24d900);

  final EdgeInsets edgePadding = const EdgeInsets.only(top: 20.0) ;
  final EdgeInsets titleEdgePadding = const EdgeInsets.only(left: 32, top: 30, right: 32, bottom: 0);

  final TextStyle titleTextStyle = const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(0xFF000000));

  final String errorText = "Something went wrong while loading data";
  final String buttonText = "Add Another Crop";
  final String errorButtonText = "Retry";

  const _DefaultStyle();
}

class PlotList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPlotState();
  }
}

class _MyPlotState extends State<PlotList> {
  @override
  Widget build(BuildContext context,
      {PlotListStyle plotStyle = const _DefaultStyle()}) {
    return Scaffold(
      body: StoreConnector<AppState, MyPlotViewModel>(
          onInit: (store) => store.dispatch(FetchCropListAction()),
          builder: (_, viewModel) => _buildBody(context, viewModel, plotStyle),
          converter: (store) => MyPlotViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, MyPlotViewModel viewModel,
      PlotListStyle myPlotStyle) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child:
            CircularProgressIndicator(),
            alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildPage(
            context, viewModel.cropsList, myPlotStyle, viewModel.goToDetail);
      case LoadingStatus.ERROR:
        return _buildErrorPage(
            context, viewModel, myPlotStyle); // TODO Check FARM-203
    }
  }


  Widget _buildPage(BuildContext context, List<CropEntity> cropList,
      PlotListStyle plotStyle, Function goToDetail) {
    final viewModel = buildPlotListViewModel();
    return HeaderAndFooterListView.builder(
        itemCount: cropList.length,
        itemBuilder: (BuildContext context, int index) {
          final itemViewModel = fromCropEntityToViewModel(
              cropList[index], goToDetail);
          return PlotListItem().buildListItem(itemViewModel);
        },
        physics: ScrollPhysics(),
        shrinkWrap: true,
        header: _buildTitle(viewModel, plotStyle, context: context),
        footer: RoundedButton(viewModel: RoundedButtonViewModel(title: viewModel.buttonTitle, onTap: () => _showToast(context)),
            style: RoundedButtonStyle.largeRoundedButtonStyle()));
  }

  Widget _buildTitle(PlotListViewModel viewModel, PlotListStyle myPlotStyle,
      {BuildContext context}) {
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
                  ]
              ),
              RoundedButton(viewModel:
                  RoundedButtonViewModel(icon: "assets/icons/profit_add.png", onTap: () => _showToast(context)),
                  style: RoundedButtonStyle.compactRoundedButton())
            ]
        )
    );
  }

  Widget _buildErrorPage(BuildContext context, MyPlotViewModel viewModel,
      PlotListStyle plotStyle) {
    final String retryButton = "Retry";
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AlertDialog(
              title: Text(
                  plotStyle.errorText),
              actions: <Widget>[
                FlatButton(
                    child: Text(
                        retryButton),
                    onPressed: () {
                      //FIXME: Needs to implement the retry functionality
                    }
                )
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
    scaffold.showSnackBar(
        SnackBar(
          content: Text(
              toastText
          ),
          action: SnackBarAction(label: toastButtonText, onPressed: scaffold.hideCurrentSnackBar),
        )
    );
  }

}
