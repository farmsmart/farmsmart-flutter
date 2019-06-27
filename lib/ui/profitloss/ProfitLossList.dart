import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/profit_loss_viewmodel.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/CompactRoundedButtonStyle.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:redux/redux.dart';



class ProfitLossViewModel {
  LoadingStatus loadingStatus;
  final String title;
  final String detailText;
  final String subtitle;

  ProfitLossViewModel({this.title, this.detailText, this.subtitle, this.loadingStatus});

  static ProfitLossViewModel fromStore(Store<AppState> store) {
    return ProfitLossViewModel(loadingStatus: LoadingStatus.SUCCESS);
  }
}

ProfitLossViewModel buildProfitLossViewModel() {
  return ProfitLossViewModel(title: "2,150", detailText: "KSh", subtitle: "▲ 498 (17.4%)", loadingStatus: LoadingStatus.SUCCESS);
}

abstract class ProfitLossStyle {

  final TextStyle titleTextStyle;
  final TextStyle detailTextStyle;
  final TextStyle subtitleTextStyle;

  final Color actionButtonBackgroundColour;
  final EdgeInsets titleEdgePadding;

  final double detailTextEdgePadding;

  final double actionButtonSize;
  final double actionButtonElevation;
  final double actionButtonIconSize;

  ProfitLossStyle(this.actionButtonBackgroundColour, this.actionButtonSize,
      this.actionButtonElevation, this.actionButtonIconSize, this.titleEdgePadding,
      this.titleTextStyle, this.detailTextEdgePadding, this.detailTextStyle,
      this.subtitleTextStyle);
}

class _DefaultStyle implements ProfitLossStyle{

  final TextStyle titleTextStyle = const TextStyle(fontSize: 47, fontWeight: FontWeight.bold, color: Color(0xFF1a1b46));
  final TextStyle detailTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xFF767690));
  final TextStyle subtitleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xFF25df0c));

  final EdgeInsets titleEdgePadding = const EdgeInsets.only(left: 33, top: 36.5, bottom: 12.5);

  final double detailTextEdgePadding = 10;

  final Color actionButtonBackgroundColour = const Color(0xFF25df0c);
  final double actionButtonSize = 48.0;
  final double actionButtonElevation = 0;
  final double actionButtonIconSize = 20.0;

  const _DefaultStyle();
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

  Widget _buildBody(BuildContext context, ProfitLossViewModel viewModel, {ProfitLossStyle profitStyle = const _DefaultStyle()}) {
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
    final viewModel = buildProfitLossViewModel();

    return HeaderAndFooterListView.builder(
      //FIXME: itemCount is now hardcoded
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
         final itemViewModel = buildProfitLossItemViewModel();
         return ProfitLossListItem().buildListItem(itemViewModel);
        },
    physics: ScrollPhysics(),
    shrinkWrap: true,
      header: _buildTitle(profitStyle, viewModel),
      footer: SizedBox(height: 51,)
    );
  }

  Widget _buildTitle(ProfitLossStyle profitStyle, ProfitLossViewModel viewModel) {
    return Container(
      margin: profitStyle.titleEdgePadding,
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
                width: profitStyle.detailTextEdgePadding,
              ),
              Text(
                viewModel.detailText,
                style: profitStyle.detailTextStyle,
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
      child: GestureDetector(
        child: Text(
          viewModel.subtitle,
          style: profitStyle.subtitleTextStyle
    ),
        onTap: () {
          //FIXME: Add navigation to the next screen when finished
        },
      ));
  }

  Widget _buildPageWithFloatingButton(BuildContext context, ProfitLossViewModel viewModel, ProfitLossStyle profitStyle) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _buildPage(context, viewModel, profitStyle),
        floatingActionButton: RoundedButton.build(style: CompactBigRoundedButtonStyle(),context: context, icon: Icons.add)
    );
  }
}

