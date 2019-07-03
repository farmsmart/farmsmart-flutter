import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountListItem.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';

class RecordAmountViewModel {
  LoadingStatus loadingStatus;
  List<RecordAmountListItemViewModel> actions;
  String amount;
  String buttonTitle;

  RecordAmountViewModel(this.loadingStatus, this.actions, this.amount, this.buttonTitle);
}

class RecordAmount extends StatelessWidget {
  final RecordAmountViewModel _viewModel;

  const RecordAmount(
      {Key key, RecordAmountViewModel viewModel})
      : this._viewModel = viewModel,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _build(context, _viewModel);
  }

  @override
  Widget _build(BuildContext context, RecordAmountViewModel viewModel) {
    return Scaffold(
      body: _buildBody(context, viewModel),
    );
  }

  Widget _buildBody(BuildContext context, RecordAmountViewModel viewModel) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildList(context, viewModel);
      case LoadingStatus.ERROR:
        return Text(Strings.errorString);
    }
  }

  Widget _buildList(BuildContext context, RecordAmountViewModel viewModel) {
    return HeaderAndFooterListView.builder(
        itemCount: viewModel.actions.length,
        itemBuilder: (BuildContext context, int index) {
          return RecordAmountListItem(viewModel: viewModel.actions[index],
              style: index+1 != viewModel.actions.length ? RecordAmountListItemStyle.defaultStyle() : RecordAmountListItemStyle.fillStype(),
              currentAction: index,
              numberOfActions: viewModel.actions.length);
        },
        physics: ScrollPhysics(),
        shrinkWrap: true,
        header: RecordAmountHeader(viewModel: RecordAmountHeaderViewModel(viewModel.amount), style: RecordAmountHeaderStyle.defaultCostStyle()),
        footer: RoundedButton.build(context: context, title: viewModel.buttonTitle, onTap: null) //FIXME: use new button
    );
  }
}
