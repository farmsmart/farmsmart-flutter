import 'package:farmsmart_flutter/ui/common/listDivider.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/material.dart';


class ProfitLossItemViewModel {
  final String title;
  final String subTitle;
  final String detail;

  ProfitLossItemViewModel(this.title, this.subTitle, this.detail);
}

ProfitLossItemViewModel buildProfitLossItemViewModel() {
  return ProfitLossItemViewModel("Title", "SubTitle", "Detail");
}

class HomeProfitLossChild {
  Widget buildListItem(ProfitLossItemViewModel viewModel) {
    return GestureDetector(
        //onTap: viewModel.onTap,
        child: Card(
            margin: const EdgeInsets.all(0),
            elevation: 0,
            child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 32.0, top: 27.0, right: 32.0, bottom: 27.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildMainTextView(viewModel),
                        SizedBox(width: 23),
                      ])),
              ListDivider.build(),
            ]
            )
        )
    );
  }
}

_buildMainTextView(ProfitLossItemViewModel viewModel) {
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(viewModel.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          SizedBox(height: 5),
          Text(viewModel.subTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis)
        ],
      ),
      Text(
        "TESTING",
        textAlign: TextAlign.end,
      )
    ],
    ),
  );
}

