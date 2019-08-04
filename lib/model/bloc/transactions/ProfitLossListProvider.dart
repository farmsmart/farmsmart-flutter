import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/transactions/TransactionToProfitLossListItemViewModel.dart';
import 'package:farmsmart_flutter/model/model/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/crop/CropRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossList.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:intl/intl.dart';
import '../ViewModelProvider.dart';
import 'TransactionToRecordTransactionViewModel.dart';


class _Strings {
  static const generalItemTag = "General";
  static const currentcyTag = "GBP";
}

class ProfitLossListProvider
    implements ViewModelProvider<ProfitLossListViewModel> {
  final TransactionRepositoryInterface _transactionsRepository;
  final CropRepositoryInterface _cropRepository;
  ProfitLossListViewModel _snapshot;
  final StreamController<ProfitLossListViewModel> _controller =
      StreamController<ProfitLossListViewModel>.broadcast();
  List<String> _taglist = [];
  String _title = "";

  ProfitLossListProvider({
    TransactionRepositoryInterface transactionsRepository,
    CropRepositoryInterface cropRepository,
  }) : this._transactionsRepository = transactionsRepository, this._cropRepository = cropRepository;

  @override
  Stream<ProfitLossListViewModel> stream() {
    return _controller.stream;
  }

  @override
  ProfitLossListViewModel snapshot() {
    return _snapshot;
  }

  @override
  ProfitLossListViewModel initial() {
    if (_snapshot == null) {
      _taglist= _getTagList([]);
      _transactionsRepository.observeProfile(null).listen((transactions) {
        _transactionsRepository.allTimeBalance().then((balance) {
          _title = balance.toString(allowNegative:true);
          _cropRepository.get().then((crops) {
            _taglist= _getTagList(crops);
            _snapshot = _viewModelFromModel(_controller, transactions);
            _controller.sink.add(_snapshot);
          });
        });
      });
      _snapshot = _viewModel(status: LoadingStatus.LOADING);
      _snapshot.refresh();
    }
    return _snapshot;
  }

  ProfitLossListViewModel _viewModelFromModel(
      StreamController controller, List<TransactionEntity> transactions) {
    final items = transactions?.map((transaction) {
          final transformer = TransactionToProfitLossListItemViewModel(
              TransactionToRecordTransactionViewModel(
                  _transactionsRepository, _taglist));
          return transformer.transform(from: transaction);
        })?.toList() ??
        _snapshot.transactions;
    return _viewModel(
      status: LoadingStatus.SUCCESS,
      items: items,
    );
  }

  ProfitLossListViewModel _viewModel({
    LoadingStatus status,
    List<ProfitLossListItemViewModel> items = const [],
  }) {
    final transformer = TransactionToRecordTransactionViewModel(
        _transactionsRepository, _taglist);
    final costViewModel = transformer.costViewModel();
    final saleViewModel = transformer.saleViewModel();
    final currencyName = NumberFormat.simpleCurrency(locale:Intl.getCurrentLocale()).currencyName;
    return ProfitLossListViewModel(
      title: _title,
      detailText: currencyName ,
      loadingStatus: status,
      transactions: items,
      costViewModel: costViewModel,
      saleViewModel: saleViewModel,
      refresh: () => _update(_controller),
    );
  }

  void _update(StreamController controller) {
    _transactionsRepository.get(null);
  }

  List<String> _getTagList(List<CropEntity> crops){
    final defaultItems = [Intl.message(_Strings.generalItemTag)];
    return defaultItems + crops.map((crop){
      return crop.name;
    }).toList();
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
