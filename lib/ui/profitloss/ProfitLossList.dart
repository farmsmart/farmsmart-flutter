import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/CompactRoundedButtonStyle.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:redux/redux.dart';
import 'mockRepositoryTryout/MockTransactionRepository.dart';


class ProfitLossListViewModel {
  LoadingStatus loadingStatus;
  final String title;
  final String subtitle;
  final String detailText;

  final List<ProfitLossListItemViewModel> transactions;

  ProfitLossListViewModel({this.title, this.detailText, this.subtitle, this.loadingStatus, this.transactions});

  static ProfitLossListViewModel fromStore(Store<AppState> store) {
    final mockViewModel = MockProfitLossListViewModel.build();

    return mockViewModel;
  }
}

abstract class ProfitLossStyle {

  final TextStyle titleTextStyle;
  final TextStyle detailTextStyle;
  final TextStyle subtitleTextStyle;

  final Color actionButtonBackgroundColour;
  final EdgeInsets titleEdgePadding;

  final double detailTextSpacing;

  final double actionButtonSize;
  final double actionButtonElevation;
  final double actionButtonIconSize;
  final int maxLines;
  final double bottomEdgePadding;

  ProfitLossStyle(this.actionButtonBackgroundColour, this.actionButtonSize,
      this.actionButtonElevation, this.actionButtonIconSize, this.titleEdgePadding,
      this.titleTextStyle, this.detailTextSpacing, this.detailTextStyle,
      this.subtitleTextStyle, this.maxLines, this.bottomEdgePadding);
}

class _DefaultStyle implements ProfitLossStyle{

  final TextStyle titleTextStyle = const TextStyle(fontSize: 47, fontWeight: FontWeight.bold, color: Color(0xFF1a1b46));
  final TextStyle detailTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xFF767690));
  final TextStyle subtitleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xFF25df0c));

  final EdgeInsets titleEdgePadding = const EdgeInsets.only(left: 33, top: 36.5, bottom: 12.5);

  final double detailTextSpacing = 10;

  final Color actionButtonBackgroundColour = const Color(0xFF25df0c);
  final double actionButtonSize = 48.0;
  final double actionButtonElevation = 0;
  final double actionButtonIconSize = 20.0;
  final int maxLines = 1;
  final double bottomEdgePadding = 51;

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
      body: StoreConnector<AppState, ProfitLossListViewModel>(
          builder: (_, viewModel) => _buildBody(context, viewModel),
          converter: (store) => ProfitLossListViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, ProfitLossListViewModel viewModel, {ProfitLossStyle profitStyle = const _DefaultStyle()}) {
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

  Widget _buildPage(BuildContext context, ProfitLossListViewModel viewModel, ProfitLossStyle profitStyle) {

    return HeaderAndFooterListView.builder(
        itemCount: viewModel.transactions.length,
        itemBuilder: (BuildContext context, int index) {
         return ProfitLossListItem().buildListItem(viewModel.transactions[index]);
        },
    physics: ScrollPhysics(),
    shrinkWrap: true,
      header: _buildTitle(profitStyle, viewModel),
      footer: SizedBox(height: profitStyle.bottomEdgePadding,)
    );
  }

  Widget _buildTitle(ProfitLossStyle profitStyle, ProfitLossListViewModel viewModel) {
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
                  style: profitStyle.titleTextStyle,
                  maxLines: profitStyle.maxLines,
                  overflow: TextOverflow.ellipsis
              ),
              SizedBox(
                width: profitStyle.detailTextSpacing,
              ),
              Text(
                viewModel.detailText,
                style: profitStyle.detailTextStyle,
                  maxLines: profitStyle.maxLines,
                  overflow: TextOverflow.ellipsis
              )
            ],
          ),
          Row(
            children: <Widget>[
              _buildSubTitle(viewModel, profitStyle),
            ],
          )
        ]),
    );
    }

    Widget _buildSubTitle(ProfitLossListViewModel viewModel, ProfitLossStyle profitStyle) {
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

  Widget _buildPageWithFloatingButton(BuildContext context, ProfitLossListViewModel viewModel, ProfitLossStyle profitStyle) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _buildPage(context, viewModel, profitStyle),
        floatingActionButton: RoundedButton.build(style: CompactBigRoundedButtonStyle(),context: context, icon: Icons.add)
    );
  }
}

