import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:farmsmart_flutter/ui/myplot/my_plot_child_item.dart';
import 'package:farmsmart_flutter/ui/myplot/myplot_viewmodel.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'new_my_plot_child_item.dart';

class HomeMyPlotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPlotState();
  }
}

class _MyPlotState extends State<HomeMyPlotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, MyPlotViewModel>(
          onInit: (store) => store.dispatch(new FetchCropListAction()),
          builder: (_, viewModel) => _buildBody(context, viewModel),
          converter: (store) => MyPlotViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, MyPlotViewModel viewModel) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        //return _buildList(context, viewModel.cropsList, viewModel.goToDetail, viewModel.goToStage); // Change fetch crops to go to detail
        return _buildPage(context, viewModel.cropsList);
      case LoadingStatus.ERROR:
        return Text("Error"); // TODO Check FARM-203
    }
  }
}

/*Widget _buildList(BuildContext context, List<CropEntity> cropList, Function goToDetail, Function goToStage) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: cropList
        .map((cropData) => MyPlotListItem().buildListItem(cropData, goToDetail, goToStage))
        .toList(),
  );
}*/

Widget _buildTest(BuildContext context, List<CropEntity> cropList){
  return ListView.builder(
    padding: const EdgeInsets.only(top: 20.0),
    itemCount: cropList.length,
    itemBuilder: (BuildContext context, int index) {
      return MyNewPlotListItem().buildListItem(cropList[index]);
    },
  );
}

Widget _buildPage(BuildContext context, List<CropEntity> cropList){
  return Column(
    children: <Widget>[
      _buildTittle(),
      Expanded(child: _buildTest(context, cropList))
    ],
  );
}

Widget _buildTittle(){
  return Container(
    padding: Paddings.title(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                Strings.myPlotTab,
                style: Styles.titleTextStyle(),
              )
            ],
          ),
          Column(
            children: <Widget>[
              _addButton()
            ],
          )],
      ),
  );
}

Widget _addButton(){
  const buttonShapeRaidus = 25.0;
  const buttonIconSize = 15.0;

  return ButtonTheme(
    height: buttonShapeRaidus,
    child: FlatButton(
      onPressed: () {},
      child: Icon(
        Icons.add,
        size: buttonIconSize,
        color: Color(white),
      ),
      shape: CircleBorder(),
      // FIXME: Color should be the correct one
      color: Color(primaryGreen),
    ),
  );
}