import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/profitloss/profit_loss_viewmodel.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';




class ProfitLossPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ProfitLossState();
  }
}

class _ProfitLossState extends State<ProfitLossPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, ProfitLossViewModel>(
          builder: (_, viewModel) => _buildBody(context, viewModel),
          converter: (store) => ProfitLossViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, ProfitLossViewModel viewModel) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildPage(context, viewModel);
      case LoadingStatus.ERROR:
        return Text(Strings.errorString);
    }
  }

  Widget _buildPage(BuildContext context, ProfitLossViewModel viewModel) {
    return ListView(
      children: <Widget>[
        _buildTitle(),
      ],
    );
  }

  Widget _buildTitle() {
  }




  }
