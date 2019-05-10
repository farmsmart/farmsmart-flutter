import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:farmsmart_flutter/ui/myplot/my_plot_child_item.dart';
import 'package:farmsmart_flutter/ui/myplot/myplot_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
        return _buildList(context, viewModel.cropsList, viewModel.goToDetail, viewModel.goToStage); // Change fetch crops to go to detail
      case LoadingStatus.ERROR:
        return Text("Error"); // TODO Check FARM-203
    }
  }
}

Widget _buildList(BuildContext context, List<CropEntity> cropList, goToDetail, goToStage) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: cropList
        .map((cropData) => MyPlotListItem().buildListItem(cropData, goToDetail, goToStage))
        .toList(),
  );
}

