import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';

class StartupViewModel implements RefreshableViewModel, LoadableViewModel {
  final LoadingStatus loadingStatus;
  final Function refresh;
  final bool isLoggedIn;

  StartupViewModel(this.loadingStatus, this.refresh, this.isLoggedIn);
}