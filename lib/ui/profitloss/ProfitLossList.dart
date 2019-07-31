import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:flutter/material.dart';

class ProfitLossListViewModel {
  LoadingStatus loadingStatus;
  final String title;
  final String detailText;

  final List<ProfitLossListItemViewModel> transactions;

  ProfitLossListViewModel({
    this.title,
    this.detailText,
    this.loadingStatus,
    this.transactions,
  });
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

class ProfitLossPage extends StatefulWidget {
  final ProfitLossListViewModel _viewModel;

  const ProfitLossPage({Key key, ProfitLossListViewModel viewModel})
      : this._viewModel = viewModel,
        super(key: key);

  State<StatefulWidget> createState() => _ProfitLossState();
}

class _ProfitLossState extends State<ProfitLossPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context, widget._viewModel),
    );
  }

  Widget _buildBody(BuildContext context, ProfitLossListViewModel viewModel,
      {ProfitLossStyle profitStyle = const _DefaultStyle()}) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildPageWithFloatingButton(context, viewModel, profitStyle);
      case LoadingStatus.ERROR:
        return Text("This will be refactored with view model provider next PR");
    }
  }

  Widget _buildPage(BuildContext context, ProfitLossListViewModel viewModel,
      ProfitLossStyle profitStyle) {
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
            height: profitStyle.bottomEdgePadding,
          )
        ]);
  }

  Widget _buildPageWithFloatingButton(BuildContext context,
      ProfitLossListViewModel viewModel, ProfitLossStyle profitStyle) {
    final String roundedButtonIcon = "assets/icons/profit_add.png";
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _buildPage(context, viewModel, profitStyle),
        floatingActionButton: RoundedButton(
            viewModel: RoundedButtonViewModel(
                icon: roundedButtonIcon, onTap: () => _showToast(context)),
            style: RoundedButtonStyle.bigRoundedButton()));
  }

  //FIXME: Only is built for show that this buttons are not functional yet
  static void _showToast(BuildContext context) {
    final String toastText = "Not Implemented Yet";
    final String toastButtonText = "BACK";
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(toastText),
      action: SnackBarAction(
          label: toastButtonText, onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}
