import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/locale/locale_selection_viewmodel.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/locale/locale_repository_interface.dart';
import '../../../farmsmart_localizations.dart';
import '../ViewModelProvider.dart';

class LocaleSelectionProvider
    implements ViewModelProvider<LocaleSelectionViewModel> {
  final LocaleRepositoryInterface repo;
  final StreamController<LocaleSelectionViewModel> _controller =
      StreamController<LocaleSelectionViewModel>.broadcast();
  LocaleSelectionViewModel _snapshot = LocaleSelectionViewModel.loading();
  LocaleSelectionProvider(this.repo);

  @override
  LocaleSelectionViewModel initial() {
    _refresh();
    return _snapshot;
  }

  @override
  LocaleSelectionViewModel snapshot() {
    return _snapshot;
  }

  @override
  Stream<LocaleSelectionViewModel> stream() {
    return _controller.stream;
  }

  void _updateViewModel(ContentLocale current, List<ContentLocale> available) {
    final items = available.map((item) => _transform(item)).toList();
    _snapshot = LocaleSelectionViewModel(
      LoadingStatus.SUCCESS,
      _refresh,
      _switchLanguage,
      _transform(current),
      items,
    );
    _controller.sink.add(_snapshot);
  }

  LocaleItemViewModel _transform(ContentLocale locale) {
    return LocaleItemViewModel(
      locale.displayName,'',locale.locale
    );
  }

   Future<void> _switchLanguage(LocaleItemViewModel locale) async {
    await FarmsmartLocalizations.persistLocale(locale.locale);
    await FarmsmartLocalizations.load();
    _refresh();
  }

  void _refresh() {
    repo.currentLocale().then((current) {
      repo.availableLocales().then((available) {
        _updateViewModel(current, available);
      });
    });
  }

  void dispose() {
    _controller.close();
    _controller.sink.close();
  }
}
