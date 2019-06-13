import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'myplot_viewmodel.dart';
import 'my_plot_list.dart';

abstract class PlotListStyle {

  final Color primaryWhiteColor;
  final Color primaryGreenColor;

  final EdgeInsets edgeInsetsTop;
  final EdgeInsets edgeInsetsTitle;
  final EdgeInsets addCropBottomButtonMargins;

  final BorderRadius roundedBorderRadius;

  final Alignment circularProgressIndicatorAligmentCenter;

  final MainAxisAlignment mainAxisAlignmentSpaceBeetwen;
  final MainAxisAlignment mainAxisAlignmentSpaceStart;

  final TextStyle titleTextStyle;
  final TextStyle addCropButtonTextStyle;

  final double addCropTopButtonSize;
  final double buttonIconSize;
  final double addCropBottomButtonHeight;

  PlotListStyle(this.primaryWhiteColor, this.primaryGreenColor,
      this.edgeInsetsTop, this.edgeInsetsTitle, this.roundedBorderRadius,
      this.circularProgressIndicatorAligmentCenter,
      this.mainAxisAlignmentSpaceBeetwen, this.mainAxisAlignmentSpaceStart,
      this.titleTextStyle, this.addCropButtonTextStyle,this.addCropTopButtonSize,
      this.buttonIconSize, this.addCropBottomButtonMargins, this.addCropBottomButtonHeight);
}

class _DefaultStyle implements PlotListStyle {

  final Color primaryWhiteColor =  const Color(0xFFFFFFFF);
  final Color primaryGreenColor =  const Color(0xff25df0c);

  final EdgeInsets edgeInsetsTop = const EdgeInsets.only(top: 20.0) ;
  final EdgeInsets edgeInsetsTitle = const EdgeInsets.only(left: 25, top: 30, right: 5, bottom: 20);
  final EdgeInsets addCropBottomButtonMargins = const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0, top: 31.0);

  final BorderRadius roundedBorderRadius = const BorderRadius.all(Radius.circular(20.0));

  final Alignment circularProgressIndicatorAligmentCenter = Alignment.center;
  final MainAxisAlignment mainAxisAlignmentSpaceBeetwen = MainAxisAlignment.spaceBetween;
  final MainAxisAlignment mainAxisAlignmentSpaceStart = MainAxisAlignment.start;

  final TextStyle titleTextStyle = const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(0xFF000000));
  final TextStyle addCropButtonTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xffffffff));

  final double addCropTopButtonSize = 25.0;
  final double buttonIconSize = 15.0;
  final double addCropBottomButtonHeight = 56.0;

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
        return Text("Error"); // TODO Check FARM-203
    }
  }
}

Widget _buildCropList(BuildContext context, List<CropEntity> cropList, PlotListStyle myPlotStyle, Function goToDetail){
  return ListView.builder(
    padding: myPlotStyle.edgeInsetsTop,
    itemCount: cropList.length,
    shrinkWrap: true,
    physics: ScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return PlotListItem().buildListItem(cropList[index], goToDetail);
    },
  );
}

Widget _buildPage(BuildContext context, List<CropEntity> cropList, PlotListStyle myPlotStyle, Function goToDetail){
  return ListView(
    children: <Widget>[
      _buildTitle(myPlotStyle),
      _buildCropList(context, cropList, myPlotStyle, goToDetail),
      _buildAddCropBottomButton(myPlotStyle)
    ],
  );
}

Widget _buildTitle(PlotListStyle myPlotStyle){
  return Container(
    padding: myPlotStyle.edgeInsetsTitle,
    child: Row(
      mainAxisAlignment: myPlotStyle.mainAxisAlignmentSpaceBeetwen,
        children: <Widget>[
          Column(
            mainAxisAlignment: myPlotStyle.mainAxisAlignmentSpaceStart,
            children: <Widget>[
              Text(
                Strings.myPlotTab,
                style: myPlotStyle.titleTextStyle,
              )
            ],
          ),
          Column(
            children: <Widget>[
              _buildAddCropTopButton(myPlotStyle)
            ],
          )],
      ),
  );
}

Widget _buildAddCropTopButton(PlotListStyle myPlotStyle){
  return ButtonTheme(
    height: myPlotStyle.addCropTopButtonSize,
    child: FlatButton(
      onPressed: () {},
      child: Icon(
        Icons.add,
        size: myPlotStyle.buttonIconSize,
        color: myPlotStyle.primaryWhiteColor,
      ),
      shape: CircleBorder(),
      color: myPlotStyle.primaryGreenColor,
    ),
  );
}

Widget _buildAddCropBottomButton(PlotListStyle myPlotStyle){
    return Container(
      height: myPlotStyle.addCropBottomButtonHeight,
      margin: myPlotStyle.addCropBottomButtonMargins,
      width: double.infinity,
      decoration: BoxDecoration(
        color: myPlotStyle.primaryGreenColor,
        borderRadius: myPlotStyle.roundedBorderRadius,
      ),
      child: FlatButton(
        child: Text(
          Strings.addCropButtonText,
          style: myPlotStyle.addCropButtonTextStyle
          )
        ),
        //FIXME: Add oPressed when CropAddList available
        //onPressed: callback,
      );
  }