import 'package:farmsmart_flutter/model/bloc/transactions/TransactionToRecordTransactionViewModel.dart';
import 'package:farmsmart_flutter/model/model/TransactionEntity.dart';
import 'package:farmsmart_flutter/ui/common/DogTagStyles.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransaction.dart';

import '../Transformer.dart';

class TransactionToProfitLossListItemViewModel
    implements
        ObjectTransformer<TransactionEntity, ProfitLossListItemViewModel> {

  final TransactionToRecordTransactionViewModel _detailTransformer;

  TransactionToProfitLossListItemViewModel(this._detailTransformer);
          
  @override
  ProfitLossListItemViewModel transform({TransactionEntity from}) {
    return ProfitLossListItemViewModel(
        title: from.description,
        subtitle: _subtitle(from),
        detail: _detail(from),
        style: DogTagStyles.positiveStyle(), detailViewModel: _detailTransformer.transform(from:from));
  }

  String _subtitle(TransactionEntity from) {
    return "subtitle";
  }

  String _detail(TransactionEntity from) {
    return from.amount.toString();
  }
}
