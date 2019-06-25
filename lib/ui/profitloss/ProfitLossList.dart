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
  final String subTitle;
  final String detail;

  ProfitLossViewModel(this.title, this.subTitle, this.detail);
}

ProfitLossViewModel buildProfitLossViewModel() {
  return ProfitLossViewModel("2,150", "KSh", "▲ 498 (17.4%)");
}

abstract class ProfitLossStyle {

  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;

  final Color floatingButtonBackgroundColor;
  final CrossAxisAlignment paddingBeetwenElements;
  final EdgeInsets generalMargins;

  final double floatingButtonSize;
  final double floatingButtonElevation;
  final double floatingButtonIconSize;
  final double sizedBoxSeparation;

  ProfitLossStyle(this.floatingButtonBackgroundColor, this.floatingButtonSize,
      this.floatingButtonElevation, this.floatingButtonIconSize, this.generalMargins,
      this.paddingBeetwenElements, this.titleTextStyle, this.sizedBoxSeparation, this.subtitleTextStyle);
}

class _DefaultProfitLossStyle implements ProfitLossStyle{

  final TextStyle titleTextStyle = const TextStyle(fontSize: 47, fontWeight: FontWeight.bold, color: Color(0xFF1a1b46));
  final TextStyle subtitleTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xFF767690));

  final CrossAxisAlignment paddingBeetwenElements =  CrossAxisAlignment.baseline;
  final EdgeInsets generalMargins = const EdgeInsets.only(left: 33, top: 36.5, bottom: 12.5);

  final Color floatingButtonBackgroundColor = const Color(0xFF25df0c);

  final double floatingButtonSize = 48.0;
  final double floatingButtonElevation = 0;
  final double floatingButtonIconSize = 20.0;
  final double sizedBoxSeparation = 10;

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
          builder: (_, viewModel) => _buildBody(context, viewModel),
          converter: (store) => MyProfitLossViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, MyProfitLossViewModel viewModel, {ProfitLossStyle profitStyle = const _DefaultProfitLossStyle()}) {
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

  Widget _buildPage(BuildContext context, MyProfitLossViewModel viewModel, ProfitLossStyle profitStyle) {
    final viewModel = buildProfitLossViewModel();
    return HeaderAndFooterListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
         final itemViewModel = buildProfitLossItemViewModel();
         return HomeProfitLossChild().buildListItem(itemViewModel);
        },
    physics: ScrollPhysics(),
    shrinkWrap: true,
      header: _buildTitle(profitStyle),
    );
  }

  Widget _buildTitle(ProfitLossStyle profitStyle) {
    return Container(
      margin: profitStyle.generalMargins,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: profitStyle.paddingBeetwenElements,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                //FIXME: Change it for the ViewModel Injection
                  "2,150",
                  style: profitStyle.titleTextStyle
              ),
              SizedBox(
                width: profitStyle.sizedBoxSeparation,
              ),
              Text(
                //FIXME: Change it for the ViewModel Injection
                "KSh",
                style: profitStyle.subtitleTextStyle,
              )
            ],
          ),
          Row(
            children: <Widget>[
              _buildSubTitle(),
            ],
          )
        ])
      );
    }

    Widget _buildSubTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 43.5),
      child: GestureDetector(
        child: Text(
          "▲ 498 (17.4%)",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xFF25df0c),
        ),
    ),
        onTap: () {
          //FIXME: Add navigation to the next screen when finished
        },
      ));
  }


  //FIXME: New style for the floating button maybe ?
  Widget _buildPageWithFloatingButton(BuildContext context, MyProfitLossViewModel viewModel, ProfitLossStyle profitStyle) {
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

