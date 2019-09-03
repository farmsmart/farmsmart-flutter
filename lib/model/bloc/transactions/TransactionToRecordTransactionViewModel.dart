import 'package:farmsmart_flutter/model/entities/TransactionAmount.dart';
import 'package:farmsmart_flutter/model/entities/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransaction.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionListItem.dart';
import 'package:intl/intl.dart';
import '../Transformer.dart';

class _LocalisedStrings {
  static String recordCost() => Intl.message('Record a Cost');

  static String recordSale() => Intl.message('Record a Sale');
}

class TransactionToRecordTransactionViewModel
    extends
        ObjectTransformer<TransactionEntity, RecordTransactionViewModel> {
  final List<String> _tagList;
  final TransactionRepositoryInterface _repo;

  TransactionToRecordTransactionViewModel(this._repo, this._tagList);

  @override
  RecordTransactionViewModel transform({TransactionEntity from}) {
    if (from.amount.isCost()) {
      return costViewModel(from: from, editable: false);
    }
    return saleViewModel(from: from, editable: false);
  }

  RecordTransactionViewModel costViewModel(
      {TransactionEntity from, bool editable = true}) {
    final amount = from?.amount?.toString() ?? "";
    return RecordTransactionViewModel(
        amount: amount,
        actions: _actions(from: from),
        buttonTitle: _LocalisedStrings.recordCost(),
        recordTransaction: (data) => _record(data, TransactionType.cost),
        type: TransactionType.cost,
        isEditable: editable);
  }

  RecordTransactionViewModel saleViewModel(
      {TransactionEntity from, bool editable = true}) {
    final amount = from?.amount?.toString() ?? "";
    return RecordTransactionViewModel(
        amount: amount,
        actions: _actions(from: from),
        buttonTitle: _LocalisedStrings.recordSale(),
        recordTransaction: (data) => _record(data, TransactionType.sale),
        type: TransactionType.sale,
        isEditable: editable);
  }

  List<RecordTransactionListItemViewModel> _actions({TransactionEntity from}) {
    final timestamp = (from == null) ? DateTime.now() : from.timestamp;
    final description = (from == null) ? "" : (from.description ?? "");
    final selectedItem = (from == null) ? null : from.tag;
    return [
      RecordTransactionListItemViewModel(
        type: RecordCellType.pickDate,
        description: description,
        selectedDate: timestamp,
        listOfCrops: _tagList,
        selectedItem: selectedItem,
      ),
      RecordTransactionListItemViewModel(
        type: RecordCellType.pickItem,
        description: description,
        selectedItem: selectedItem,
        selectedDate: timestamp,
        listOfCrops: _tagList,
      ),
      RecordTransactionListItemViewModel(
        type: RecordCellType.description,
        description: description,
        selectedDate: timestamp,
        listOfCrops: _tagList,
        selectedItem: selectedItem,
      )
    ];
  }

  void _record(RecordTransactionData data, TransactionType type) {
    final isCost = (type == TransactionType.cost);
    final amount = TransactionAmount(data.amount, isCost);
    final newTransaction =
        TransactionEntity(null, amount, data.crop, data.description, data.date);
    _repo.add(newTransaction);
  }

  void _remove(TransactionEntity transaction) {
    _repo.remove(transaction);
  }
}
