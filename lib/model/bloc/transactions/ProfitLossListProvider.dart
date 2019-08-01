import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/transactions/TransactionToProfitLossListItemViewModel.dart';
import 'package:farmsmart_flutter/model/model/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossList.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';

import '../ViewModelProvider.dart';

class ProfitLossListProvider
    implements ViewModelProvider<ProfitLossListViewModel> {
  final TransactionRepositoryInterface _transactionsRepository;
  ProfitLossListViewModel _snapshot;
  final StreamController<ProfitLossListViewModel> _controller =
      StreamController<ProfitLossListViewModel>.broadcast();

  ProfitLossListProvider({
    TransactionRepositoryInterface transactionsRepository,
  }) : this._transactionsRepository = transactionsRepository;

  @override
  StreamController<ProfitLossListViewModel> observe() {
    return _controller;
  }

  @override
  ProfitLossListViewModel snapshot() {
    return _snapshot;
  }

  @override
  ProfitLossListViewModel initial() {
    if (_snapshot == null) {
      _transactionsRepository.observeProfile(null).listen((transactions) {
        _snapshot = _viewModelFromModel(_controller, transactions);
        _controller.sink.add(_snapshot);
      });
      _snapshot = _viewModel(status: LoadingStatus.LOADING);
      _snapshot.refresh();
    }
    return _snapshot;
  }

  ProfitLossListViewModel _viewModelFromModel(
      StreamController controller, List<TransactionEntity> transactions) {
    final items = transactions.map((transaction) {
      final transformer = TransactionToProfitLossListItemViewModel();
      return transformer.transform(from: transaction);
    }).toList();
    return _viewModel(
      status: LoadingStatus.SUCCESS,
      items: items,
    );
  }

  ProfitLossListViewModel _viewModel({
    LoadingStatus status,
    List<ProfitLossListItemViewModel> items = const [],
  }) {
    return ProfitLossListViewModel(
      title: "title",
      detailText: "detail",
      loadingStatus: status,
      transactions: items,
      refresh: () => _update(_controller),
    );
  }

  void _update(StreamController controller) {
    _transactionsRepository.get(null);
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
