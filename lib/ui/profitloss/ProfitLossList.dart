import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:flutter/material.dart';

class ProfitLossListViewModel implements RefreshableViewModel {
  LoadingStatus loadingStatus;
  final String title;
  final String detailText;
  Function refresh;

  final List<ProfitLossListItemViewModel> transactions;

  ProfitLossListViewModel(
      {this.title,
      this.detailText,
      this.loadingStatus,
      this.transactions,
      this.refresh});
}

abstract class ProfitLossStyle {
  final Color actionButtonBackgroundColour;
  final double actionButtonSize;
  final double actionButtonElevation;
  final double actionButtonIconSize;
  final double bottomEdgePadding;

  ProfitLossStyle(
      this.actionButtonBackgroundColour,
      this.actionButtonSize,
      this.actionButtonElevation,
      this.actionButtonIconSize,
      this.bottomEdgePadding);
}

class _DefaultStyle implements ProfitLossStyle {
  final Color actionButtonBackgroundColour = const Color(0xFF25df0c);
  final double actionButtonSize = 48.0;
  final double actionButtonElevation = 0;
  final double actionButtonIconSize = 20.0;
  final double bottomEdgePadding = 51;

  const _DefaultStyle();
}

class ProfitLossPage extends StatelessWidget {
  final ViewModelProvider<ProfitLossListViewModel> _viewModelProvider;
  final ProfitLossStyle _style;

  const ProfitLossPage({Key key, ViewModelProvider<ProfitLossListViewModel> viewModelProvider, ProfitLossStyle style = const _DefaultStyle()}) : this._viewModelProvider = viewModelProvider, this._style = style, super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProviderBuilder(
      provider: _viewModelProvider,
      successBuilder: _buildPageWithFloatingButton,
    );
  }

  Widget _buildPage({BuildContext context, ProfitLossListViewModel viewModel}) {
    return HeaderAndFooterListView(
        itemCount: viewModel.transactions.length,
        itemBuilder: (BuildContext context, int index) {
          return ProfitLossListItem(
              viewModel: viewModel.transactions[index],
              style: ProfitLossItemStyle.defaultStyle());
        },
        physics: ScrollPhysics(),
        shrinkWrap: true,
        headers: [
          ProfitLossHeader(
              viewModel: ProfitLossHeaderViewModel(
                  viewModel.title, viewModel.detailText),
              style: ProfitLossHeaderStyle.defaultStyle())
        ],
        footers: [
          SizedBox(
            height: _style.bottomEdgePadding,
          )
        ]);
  }

  Widget _buildPageWithFloatingButton(
      {BuildContext context, AsyncSnapshot<ProfitLossListViewModel> snapshot}) {
    final viewModel = snapshot.data;
    final String roundedButtonIcon = "assets/icons/profit_add.png";
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _buildPage(context: context, viewModel: viewModel),
        floatingActionButton: RoundedButton(
          viewModel:
              RoundedButtonViewModel(icon: roundedButtonIcon, onTap: () => {}),
          style: RoundedButtonStyle.bigRoundedButton(),
        ));
  }
}
