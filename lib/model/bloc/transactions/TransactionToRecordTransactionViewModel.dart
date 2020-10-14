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
    extends ObjectTransformer<TransactionEntity, RecordTransactionViewModel> {
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
      uri: from?.uri,
      amount: amount,
      actions: _actions(from: from),
      buttonTitle: _LocalisedStrings.recordCost(),
      recordTransaction: (data) => _record(data, TransactionType.cost),
      editTransaction: (oldData, data) =>
          _edit(oldData, data, TransactionType.cost),
      removeTransaction: (data) => _remove(data, TransactionType.cost),
      type: TransactionType.cost,
      isEditable: editable,
    );
  }

  RecordTransactionViewModel saleViewModel(
      {TransactionEntity from, bool editable = true}) {
    final amount = from?.amount?.toString() ?? "";
    return RecordTransactionViewModel(
      uri: from?.uri,
      amount: amount,
      actions: _actions(from: from),
      buttonTitle: _LocalisedStrings.recordSale(),
      recordTransaction: (data) => _record(data, TransactionType.sale),
      editTransaction: (oldData, data) =>
          _edit(oldData, data, TransactionType.sale),
      removeTransaction: (data) => _remove(data, TransactionType.sale),
      type: TransactionType.sale,
      isEditable: editable,
    );
  }

  List<RecordTransactionListItemViewModel> _actions({TransactionEntity from}) {
    final timestamp =
        (from?.timestamp == null) ? DateTime.now() : from.timestamp;
    final description = from?.description ?? "";
    final selectedItem = from?.tag;
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

  TransactionEntity transformRecordTransactionDataToTransactionEntity(
    RecordTransactionData data,
    TransactionType type,
  ) {
    final isCost = (type == TransactionType.cost);
    final amount = TransactionAmount(
      data.amount,
      isCost,
    );
    return TransactionEntity(
      data.uri,
      amount,
      data.crop,
      data.description,
      data.date,
    );
  }

  void _record(
    RecordTransactionData data,
    TransactionType type,
  ) {
    _repo.add(transformRecordTransactionDataToTransactionEntity(data, type));
  }

  void _edit(
    RecordTransactionData oldData,
    RecordTransactionData data,
    TransactionType type,
  ) {
    var oldTransactionEntity =
        transformRecordTransactionDataToTransactionEntity(oldData, type);
    var newTransactionEntity =
        transformRecordTransactionDataToTransactionEntity(data, type);

    _repo.remove(oldTransactionEntity).then((_) {
      _repo.add(newTransactionEntity);
    });
  }

  void _remove(RecordTransactionData data, TransactionType type) {
    _repo.remove(transformRecordTransactionDataToTransactionEntity(data, type));
  }
}
