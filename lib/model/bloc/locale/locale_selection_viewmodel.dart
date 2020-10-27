import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';
import 'package:flutter/widgets.dart';

class LocaleItemViewModel {
  final String title;
  final String subtitle;
  final Locale locale;

  LocaleItemViewModel(this.title, this.subtitle, this.locale);
}

class LocaleSelectionViewModel
    implements RefreshableViewModel, LoadableViewModel {
  final LoadingStatus loadingStatus;
  final Function refresh;
  final Future<void> Function(LocaleItemViewModel) selectLocale;
  final LocaleItemViewModel current;
  final List<LocaleItemViewModel> items;

  LocaleSelectionViewModel(
    this.loadingStatus,
    this.refresh,
    this.selectLocale,
    this.current,
    this.items,
  );

  factory LocaleSelectionViewModel.loading() {
    return LocaleSelectionViewModel(
      LoadingStatus.LOADING,
      null,
      null,
      null,
      [],
    );
  }
}
