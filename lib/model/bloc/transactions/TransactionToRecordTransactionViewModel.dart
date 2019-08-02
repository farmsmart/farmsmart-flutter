
import 'package:farmsmart_flutter/model/model/TransactionAmount.dart';
import 'package:farmsmart_flutter/model/model/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/model/mock/MockTransaction.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransaction.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionListItem.dart';

import '../Transformer.dart';

class _Strings {
  static const recordCost = "Record Cost"; 
  static const recordSale = "Record Sale";
}

class TransactionToRecordTransactionViewModel implements ObjectTransformer<TransactionEntity, RecordTransactionViewModel> {

  final List<String> _tagList;
  final TransactionRepositoryInterface _repo;
  
  TransactionToRecordTransactionViewModel(this._repo, this._tagList);

  @override
  RecordTransactionViewModel transform({TransactionEntity from}) {
    if (from.amount.isCost()) {
      return costViewModel(from: from);
    }
    return saleViewModel(from: from);
  }

  RecordTransactionViewModel costViewModel({TransactionEntity from}) {
   return RecordTransactionViewModel(
      actions: _actions(from: from),
      buttonTitle: _Strings.recordCost,
      recordTransaction: (data) => _record(data, TransactionType.cost),
      type: TransactionType.cost,
    );
  }

  RecordTransactionViewModel saleViewModel({TransactionEntity from}) {
    return RecordTransactionViewModel(
      actions: _actions(from: from),
      buttonTitle: _Strings.recordSale,
      recordTransaction: (data) => _record(data, TransactionType.sale),
      type: TransactionType.sale,
    );
  }

  List<RecordTransactionListItemViewModel> _actions({TransactionEntity from}){
    final timestamp = (from == null) ? DateTime.now(): from.timestamp;
    final description = (from == null) ? "" : from.description;
    return  [
    RecordTransactionListItemViewModel(
      type: RecordCellType.pickDate,
      description: description,
      selectedDate: timestamp,
      listOfCrops: _tagList,
    ),
    RecordTransactionListItemViewModel(
      type: RecordCellType.pickItem,
      description: description,
      selectedDate: timestamp,
      listOfCrops: _tagList,
    ),
    RecordTransactionListItemViewModel(
      type: RecordCellType.description,
      description: description,
      selectedDate: timestamp,
      listOfCrops: _tagList,
    )
  ];
  }

  void _record(RecordTransactionData data, TransactionType type) {
    final isCost = (type == TransactionType.cost);
    final amount = TransactionAmount(data.amount, isCost);
    final newTransaction = TransactionEntity(null,amount,data.crop, data.description,data.date);
      _repo.add(newTransaction);
  }

  void _remove(TransactionEntity transaction) {
    _repo.remove(transaction);
  }


}