import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'myplot_viewmodel.dart';
import 'my_plot_list.dart';
import 'roundedButtonWidget.dart';

class PlotListViewModel {
  final String title;
  final String subTitle;
  final String detail;
  final String buttonTitle;

  Function onTap;

  final Future<String> imageUrl;

  PlotListViewModel(this.title , this.subTitle, this.detail, this.imageUrl, this.onTap, this.buttonTitle);
}

PlotListViewModel fromCropEntityToViewModel(CropEntity currentCrop, Function goToDetail) {
  //FIXME: Change the mocked data "planting" and "Day 6" with the correct FirebaseData when available
  return PlotListViewModel(currentCrop.name ?? Strings.defaultCropNameText, "Planting", "Day 6", currentCrop.imageUrl, () => goToDetail(currentCrop), "Add Another Crop");
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

  final Color primaryColor =  const Color(0xff25df0c);

  final EdgeInsets edgePadding = const EdgeInsets.only(top: 20.0) ;
  final EdgeInsets titleEdgePadding = const EdgeInsets.only(left: 25, top: 30, right: 5, bottom: 20);

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
  Widget build(BuildContext context, {PlotListStyle myPlotStyle = const _DefaultStyle()}) {
    return Scaffold(
      body: StoreConnector<AppState, MyPlotViewModel>(
          onInit: (store) => store.dispatch(FetchCropListAction()),
          builder: (_, viewModel) => _buildBody(context, viewModel, myPlotStyle),
          converter: (store) => MyPlotViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, MyPlotViewModel viewModel, PlotListStyle myPlotStyle) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child:
            CircularProgressIndicator(),
            alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildPage(context, viewModel.cropsList, myPlotStyle, viewModel.goToDetail);
      case LoadingStatus.ERROR:
        return _buildErrorPage(viewModel, myPlotStyle); // TODO Check FARM-203
    }
  }
}

Widget _buildCropList(BuildContext context, List<CropEntity> cropList, PlotListStyle myPlotStyle, Function goToDetail){
  return ListView.builder(
    padding: myPlotStyle.edgePadding,
    itemCount: cropList.length,
    shrinkWrap: true,
    physics: ScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return PlotListItem().buildListItem(fromCropEntityToViewModel(cropList[index], goToDetail));
    },
  );
}

Widget _buildPage(BuildContext context, List<CropEntity> cropList, PlotListStyle plotStyle, Function goToDetail, {RoundedButtonStyle buttonStyle = const defaultLargeRoundedButtonStyle()}){
  return ListView(
    children: <Widget>[
      _buildTitle(plotStyle),
      _buildCropList(context, cropList, plotStyle, goToDetail),

      //FIXME: We should pass the onTap for everyButton when needed
      buildRoundedButton(defaultLargeRoundedButtonStyle(), title: plotStyle.buttonText)
    ],
  );
}

Widget _buildTitle(PlotListStyle myPlotStyle, {RoundedButtonStyle buttonStyle = const defaultSmallRoundedButtonStyle()}){
  return Container(
    padding: myPlotStyle.titleEdgePadding,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                Strings.myPlotTab,
                style: myPlotStyle.titleTextStyle,
              )
            ]
          ),
          Column(
            children: <Widget>[
              //FIXME: We should pass the onTap for everyButton when needed
              buildRoundedButton(defaultSmallRoundedButtonStyle(), icon: Icons.add)
            ]
          )]
      )
  );
}

Widget _buildErrorPage(MyPlotViewModel viewModel, PlotListStyle plotStyle){
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          plotStyle.errorText
        ),
        //FIXME:NEEDS TO BE FIXED
        //buildButton(plotStyle.errorButtonText, onTap: viewModel.fetchCrops)
      ]
    )
  );
}


