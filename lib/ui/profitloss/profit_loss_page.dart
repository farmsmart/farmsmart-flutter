import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/profitloss/profit_loss_viewmodel.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';


abstract class ProfitLossStyle {
  final Color floatingButtonBackgroundColor;

  final double floatingButtonSize;
  final double floatingButtonElevation;
  final double floatingButtonIconSize;

  ProfitLossStyle(this.floatingButtonBackgroundColor, this.floatingButtonSize,
      this.floatingButtonElevation, this.floatingButtonIconSize);
}

class _DefaultProfitLossStyle implements ProfitLossStyle{
  final Color floatingButtonBackgroundColor = const Color(0xFF25df0c);

  final double floatingButtonSize = 48.0;
  final double floatingButtonElevation = 0;
  final double floatingButtonIconSize = 20.0;


  const _DefaultProfitLossStyle();
}



class ProfitLossPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ProfitLossState();
  }
}

class _ProfitLossState extends State<ProfitLossPage>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, ProfitLossViewModel>(
          builder: (_, viewModel) => _buildBody(context, viewModel),
          converter: (store) => ProfitLossViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, ProfitLossViewModel viewModel,{ProfitLossStyle profitStyle = const _DefaultProfitLossStyle()}) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildPageWithFloatingButton(context, viewModel, profitStyle);
      case LoadingStatus.ERROR:
        return Text(Strings.errorString);
    }
  }

  Widget _buildPage(BuildContext context, ProfitLossViewModel viewModel, ProfitLossStyle profitStyle) {
    return ListView(
      children: <Widget>[
        _buildTitle(),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(left: 33, top: 36.5, bottom: 12.5),
      child: Row(
        children: <Widget>[
          Text(
              "2,150",
              style: TextStyle(fontSize: 47, fontWeight: FontWeight.bold, color: Color(0xFF1a1b46),
              )),
          SizedBox(
            width: 12.5,
          ),
          Text(
            "KSh",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xFF767690),
          ))
        ])
      );
    }

  Widget _buildPageWithFloatingButton(BuildContext context, ProfitLossViewModel viewModel, ProfitLossStyle profitStyle) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _buildPage(context, viewModel, profitStyle),
        floatingActionButton: Container(
          height: profitStyle.floatingButtonSize,
          width: profitStyle.floatingButtonSize,
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add, size: profitStyle.floatingButtonIconSize),
            backgroundColor: profitStyle.floatingButtonBackgroundColor,
            elevation: profitStyle.floatingButtonElevation,
          ),
        ));
  }
}
