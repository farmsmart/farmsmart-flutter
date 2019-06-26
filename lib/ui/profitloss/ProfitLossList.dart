import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/profit_loss_viewmodel.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';

class ProfitLossViewModel {
  final String title;
  final String titleDetail;
  final String subTitle;

  ProfitLossViewModel(this.title, this.titleDetail, this.subTitle);
}

ProfitLossViewModel buildProfitLossViewModel() {
  return ProfitLossViewModel("2,150", "KSh", "▲ 498 (17.4%)");
}

abstract class ProfitLossStyle {

  final TextStyle titleTextStyle;
  final TextStyle titleDetailTextStyle;
  final TextStyle subTitleTextStyle;

  final Color floatingButtonBackgroundColor;
  final EdgeInsets generalMargins;
  final EdgeInsets subTitleEdgePadding;

  final double titleDetailEdgePadding;

  final double floatingButtonSize;
  final double floatingButtonElevation;
  final double floatingButtonIconSize;

  ProfitLossStyle(this.floatingButtonBackgroundColor, this.floatingButtonSize,
      this.floatingButtonElevation, this.floatingButtonIconSize, this.generalMargins,
      this.titleTextStyle, this.titleDetailEdgePadding, this.titleDetailTextStyle, this.subTitleEdgePadding,
      this.subTitleTextStyle);
}

class _DefaultProfitLossStyle implements ProfitLossStyle{

  final TextStyle titleTextStyle = const TextStyle(fontSize: 47, fontWeight: FontWeight.bold, color: Color(0xFF1a1b46));
  final TextStyle titleDetailTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xFF767690));
  final TextStyle subTitleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xFF25df0c));

  final EdgeInsets generalMargins = const EdgeInsets.only(left: 33, top: 36.5, bottom: 12.5);
  final EdgeInsets subTitleEdgePadding = const EdgeInsets.only(bottom: 17.5);

  final double titleDetailEdgePadding = 10;

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
      body: StoreConnector<AppState, MyProfitLossViewModel>(
          builder: (_, viewModel) => _buildBody(context, viewModel, buildProfitLossViewModel()),
          converter: (store) => MyProfitLossViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, MyProfitLossViewModel viewModel, ProfitLossViewModel profitLossViewModel, {ProfitLossStyle profitStyle = const _DefaultProfitLossStyle()}) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildPageWithFloatingButton(context, viewModel, profitLossViewModel, profitStyle);
      case LoadingStatus.ERROR:
        return Text(Strings.errorString);
    }
  }

  Widget _buildPage(BuildContext context, MyProfitLossViewModel viewModel, ProfitLossViewModel profitLossViewModel, ProfitLossStyle profitStyle) {
    final viewModel = buildProfitLossViewModel();
    return HeaderAndFooterListView.builder(
      //FIXME: itemCount is now hardcoded
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
         final itemViewModel = buildProfitLossItemViewModel();
         return HomeProfitLossChild().buildListItem(itemViewModel);
        },
    physics: ScrollPhysics(),
    shrinkWrap: true,
      header: _buildTitle(profitStyle, profitLossViewModel),
    );
  }

  Widget _buildTitle(ProfitLossStyle profitStyle, ProfitLossViewModel viewModel) {
    return Container(
      margin: profitStyle.generalMargins,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                  viewModel.title,
                  style: profitStyle.titleTextStyle
              ),
              SizedBox(
                width: profitStyle.titleDetailEdgePadding,
              ),
              Text(
                viewModel.titleDetail,
                style: profitStyle.titleDetailTextStyle,
              )
            ],
          ),
          Row(
            children: <Widget>[
              _buildSubTitle(viewModel, profitStyle),
            ],
          )
        ])
      );
    }

    Widget _buildSubTitle(ProfitLossViewModel viewModel, ProfitLossStyle profitStyle) {
    return Container(
      margin: profitStyle.subTitleEdgePadding,
      child: GestureDetector(
        child: Text(
          viewModel.subTitle,
          style: profitStyle.subTitleTextStyle
    ),
        onTap: () {
          //FIXME: Add navigation to the next screen when finished
        },
      ));
  }

  Widget _buildPageWithFloatingButton(BuildContext context, MyProfitLossViewModel viewModel, ProfitLossViewModel profitLossViewModel, ProfitLossStyle profitStyle) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _buildPage(context, viewModel,profitLossViewModel, profitStyle),
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

