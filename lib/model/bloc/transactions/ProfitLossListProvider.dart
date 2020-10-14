import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/transactions/TransactionToProfitLossListItemViewModel.dart';
import 'package:farmsmart_flutter/model/entities/PlotEntity.dart';
import 'package:farmsmart_flutter/model/entities/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossList.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:intl/intl.dart';
import '../ViewModelProvider.dart';
import 'TransactionToRecordTransactionViewModel.dart';

class _LocalisedStrings {
  static String generalItemTag() => Intl.message('General');
  static String currencyTag() => Intl.message('Currency');
}

class ProfitLossListProvider
    implements ViewModelProvider<ProfitLossListViewModel> {
  final TransactionRepositoryInterface _transactionsRepository;
  final PlotRepositoryInterface _plotRepository;
  ProfitLossListViewModel _snapshot;
  List<TransactionEntity> _transactions;
  final StreamController<ProfitLossListViewModel> _controller =
      StreamController<ProfitLossListViewModel>.broadcast();
  List<String> _taglist = [];
  String _title = "";

  ProfitLossListProvider({
    TransactionRepositoryInterface transactionsRepository,
    PlotRepositoryInterface plotRepository,
  })  : this._transactionsRepository = transactionsRepository,
        this._plotRepository = plotRepository;

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
      _taglist = _getTagList([]);
      _plotRepository.observeFarm().listen((plots) {
            _taglist = _getTagList(plots);
            _snapshot = _viewModelFromModel(_controller, _transactions);
            _controller.sink.add(_snapshot);
      });
      _transactionsRepository.stream().listen((transactions) {
        _transactions = transactions;
        _transactionsRepository.allTimeBalance().then((balance) {
          _title = balance.toString(allowNegative: true);
           _snapshot = _viewModelFromModel(_controller, transactions);
            _controller.sink.add(_snapshot);
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
    final currencyName = _LocalisedStrings.currencyTag();  //TODO: sort out server locale this is HACK  NumberFormat.simpleCurrency()
    return ProfitLossListViewModel(
      title: _title,
      detailText: currencyName,
      loadingStatus: status,
      transactions: items,
      costViewModel: costViewModel,
      saleViewModel: saleViewModel,
      refresh: () => _update(_controller),
    );
  }

  void _update(StreamController controller) {
    _plotRepository.getFarm();
    _transactionsRepository.get();
  }

  List<String> _getTagList(List<PlotEntity> plots) {
    final defaultItems = [_LocalisedStrings.generalItemTag()];
    Map<String,bool> uniqueTags = {};
    plots.forEach((plot){
      uniqueTags[plot.crop.name] = true;
    });
    return defaultItems + uniqueTags.keys.toList(); 
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
