import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:farmsmart_flutter/ui/myplot/myplot_viewmodel.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'new_my_plot_child_item.dart';

abstract class HomeMyPlotPageStyle {

  final Color iconButtonColor;
  final Color primaryGreen;
  final Color separatorWhite;

  final EdgeInsets edgeInsetsTop;
  final EdgeInsets edgeInsetsTitle;
  final EdgeInsets listPadding;
  final EdgeInsets paddingBetweenElements;
  final EdgeInsets paddingBeforeCropDayCount;
  final EdgeInsets paddingForDayCount;
  final EdgeInsets separatorIndent;

  final BorderRadius ovalRadiousForDayCount;

  final Alignment circularProgressIndicatorAligmentCenter;

  final MainAxisAlignment mainAxisAlignmentSpaceBeetwen;
  final MainAxisAlignment mainAxisAlignmentSpaceStart;
  final MainAxisSize mainAxisSizeMin;

  final CrossAxisAlignment crossAxisAlignmentStart;


  final TextStyle titleTextStyle;
  final TextStyle cropNameTextStyle;
  final TextStyle cropStatusTextStyle;
  final TextStyle cropDayTextStyle;

  final double buttonShapeRadious;
  final double buttonIconSize;
  final double oppacityForDayCount;
  final double separatorHeight;
  final double sizeForDayCountShape;

  HomeMyPlotPageStyle(this.iconButtonColor, this.primaryGreen,
      this.separatorWhite,
      this.edgeInsetsTop, this.edgeInsetsTitle, this.listPadding,
      this.paddingBetweenElements,this.paddingBeforeCropDayCount,
      this.paddingForDayCount,
      this.ovalRadiousForDayCount,
      this.circularProgressIndicatorAligmentCenter,
      this.mainAxisAlignmentSpaceBeetwen, this.mainAxisAlignmentSpaceStart,
      this.mainAxisSizeMin,
      this.crossAxisAlignmentStart, this.titleTextStyle, this.cropNameTextStyle,
      this.cropStatusTextStyle, this.cropDayTextStyle, this.buttonShapeRadious,
      this.buttonIconSize, this.oppacityForDayCount, this.separatorHeight, this.separatorIndent,
      this.sizeForDayCountShape);
}

class _DefaultStyle implements HomeMyPlotPageStyle {

  final Color iconButtonColor =  const Color(0xFFFFFFFF);
  final Color primaryGreen =  const Color(0xff25df0c);
  final Color separatorWhite = const Color(0xfff5f8fa);

  final EdgeInsets edgeInsetsTop = const EdgeInsets.only(top: 20.0) ;
  final EdgeInsets edgeInsetsTitle = const EdgeInsets.only(left: 25, top: 30, right: 5, bottom: 20);
  final EdgeInsets listPadding = const EdgeInsets.only(left: 25.0, top: 25.0, right: 30.0, bottom: 25.0);
  final EdgeInsets paddingBetweenElements = const EdgeInsets.only(bottom: 30);

  final EdgeInsets paddingBeforeCropDayCount = const EdgeInsets.only(bottom: 23);
  final EdgeInsets paddingForDayCount = const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 5);
  final EdgeInsets separatorIndent = const EdgeInsets.only(left: 25.0);

  final BorderRadius ovalRadiousForDayCount = const BorderRadius.all(Radius.circular(20.0));

  final Alignment circularProgressIndicatorAligmentCenter = Alignment.center;
  final MainAxisAlignment mainAxisAlignmentSpaceBeetwen = MainAxisAlignment.spaceBetween;
  final MainAxisAlignment mainAxisAlignmentSpaceStart = MainAxisAlignment.start;
  final CrossAxisAlignment crossAxisAlignmentStart =   CrossAxisAlignment.start;
  final MainAxisSize mainAxisSizeMin = MainAxisSize.min;

  final TextStyle titleTextStyle = const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(0xFF000000));
  final TextStyle cropNameTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff1a1b46));
  final TextStyle cropStatusTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff767690));
  final TextStyle cropDayTextStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xff25df0c));

  final double buttonShapeRadious = 25.0;
  final double buttonIconSize = 15.0;
  final double oppacityForDayCount = 0.08;
  final double separatorHeight = 2;
  final double sizeForDayCountShape = 80.0;

  const _DefaultStyle();
}

class HomeMyPlotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPlotState();
  }
}

class _MyPlotState extends State<HomeMyPlotPage> {
  @override
  Widget build(BuildContext context, {HomeMyPlotPageStyle myPlotStyle = const _DefaultStyle()}) {
    return Scaffold(
      body: StoreConnector<AppState, MyPlotViewModel>(
          onInit: (store) => store.dispatch(FetchCropListAction()),
          builder: (_, viewModel) => _buildBody(context, viewModel, myPlotStyle),
          converter: (store) => MyPlotViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, MyPlotViewModel viewModel, HomeMyPlotPageStyle myPlotStyle) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child:
            CircularProgressIndicator(),
            alignment: myPlotStyle.circularProgressIndicatorAligmentCenter);
      case LoadingStatus.SUCCESS:
        return _buildPage(context, viewModel.cropsList, myPlotStyle);
      case LoadingStatus.ERROR:
        return Text("Error"); // TODO Check FARM-203
    }
  }
}

Widget _buildCropList(BuildContext context, List<CropEntity> cropList, HomeMyPlotPageStyle myPlotStyle){
  return ListView.builder(
    padding: myPlotStyle.edgeInsetsTop,
    itemCount: cropList.length,
    shrinkWrap: true,
    physics: ScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return MyNewPlotListItem().buildListItem(cropList[index], myPlotStyle);
    },
  );
}

Widget _buildPage(BuildContext context, List<CropEntity> cropList, HomeMyPlotPageStyle myPlotStyle){
  return ListView(
    children: <Widget>[
      _buildTittle(myPlotStyle),
      _buildCropList(context, cropList, myPlotStyle)
    ],
  );
}

Widget _buildTittle(HomeMyPlotPageStyle myPlotStyle){
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
              _addButton(myPlotStyle)
            ],
          )],
      ),
  );
}

Widget _addButton(HomeMyPlotPageStyle myPlotStyle){

  return ButtonTheme(
    height: myPlotStyle.buttonShapeRadious,
    child: FlatButton(
      onPressed: () {},
      child: Icon(
        Icons.add,
        size: myPlotStyle.buttonIconSize,
        color: myPlotStyle.iconButtonColor,
      ),
      shape: CircleBorder(),
      color: myPlotStyle.primaryGreen,
    ),
  );
}