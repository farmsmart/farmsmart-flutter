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

class CropListViewModel {
  final String title;
  final String subTitle;
  final String detail;
  final String buttonTitle;

  Function onTap;

  final Future<String> imageUrl;

  CropListViewModel(this.title , this.subTitle, this.detail, this.imageUrl, this.onTap, this.buttonTitle);
}

CropListViewModel fromCropEntityToViewModel(CropEntity currentCrop, Function goToDetail) {
  //FIXME: Change the mocked data "planting" and "Day 6" with the correct FirebaseData when available
  return CropListViewModel(currentCrop.name ?? Strings.defaultCropNameText, "Planting", "Day 6", currentCrop.imageUrl, () => goToDetail(currentCrop), "Add Another Crop");
}

abstract class PlotListStyle {

  final Color primaryColor;
  final Text errorText;

  final EdgeInsets edgePadding;
  final EdgeInsets titleEdgePadding;

  final Alignment circularProgressIndicatorAligmentCenter;
  final String buttonText;

  final TextStyle titleTextStyle;

  PlotListStyle(this.primaryColor, this.edgePadding, this.titleEdgePadding,
      this.circularProgressIndicatorAligmentCenter,
      this.titleTextStyle, this.errorText, this.buttonText);
}

class _DefaultStyle implements PlotListStyle {

  final Color primaryColor =  const Color(0xff25df0c);

  final EdgeInsets edgePadding = const EdgeInsets.only(top: 20.0) ;
  final EdgeInsets titleEdgePadding = const EdgeInsets.only(left: 25, top: 30, right: 5, bottom: 20);

  final Alignment circularProgressIndicatorAligmentCenter = Alignment.center;
  final MainAxisAlignment mainAxisAlignmentSpaceBetween = MainAxisAlignment.spaceBetween;
  final MainAxisAlignment mainAxisAlignmentSpaceStart = MainAxisAlignment.start;

  final TextStyle titleTextStyle = const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(0xFF000000));

  final Text errorText = const Text("Error");
  final String buttonText = "Add Another Crop";


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
            alignment: myPlotStyle.circularProgressIndicatorAligmentCenter);
      case LoadingStatus.SUCCESS:
        return _buildPage(context, viewModel.cropsList, myPlotStyle, viewModel.goToDetail);
      case LoadingStatus.ERROR:
        return myPlotStyle.errorText; // TODO Check FARM-203
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

Widget _buildPage(BuildContext context, List<CropEntity> cropList, PlotListStyle myPlotStyle, Function goToDetail){
  return ListView(
    children: <Widget>[
      _buildTitle(myPlotStyle),
      _buildCropList(context, cropList, myPlotStyle, goToDetail),
      buildAddCropBottomButton(myPlotStyle.buttonText)
    ],
  );
}

Widget _buildTitle(PlotListStyle myPlotStyle){
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
            ],
          ),
          Column(
            children: <Widget>[
              buildAddCropTopButton()
            ],
          )],
      ),
  );
}
