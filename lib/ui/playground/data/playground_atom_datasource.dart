import 'package:farmsmart_flutter/ui/profitloss/RecordAmountDate.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountHeader.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';

class PlayGroundAtomDataSource implements PlaygroundDataSource {
  @override
  List<Widget> getList() {
    return [
      //Add your atoms here
      Text('Atom widget 1'),
      Card(child: Text('Atom widget 2')),
      Text('Atom widget 4'),
      RecordAmountHeader(viewModel: RecordAmountHeaderViewModel("00"), style: RecordAmountHeaderStyle.defaultCostStyle()),
      RecordAmountHeader(viewModel: RecordAmountHeaderViewModel("00"), style: RecordAmountHeaderStyle.defaultSaleStyle()),
      RecordAmountDate(viewModel: RecordAmountDateViewModel("assets/icons/detail_icon_date.png", "Date", "Today", "assets/icons/chevron.png"))
    ];
  }
}
