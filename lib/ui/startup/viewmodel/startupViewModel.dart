import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/LandingPage.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';

class StartupViewModel implements RefreshableViewModel, LoadableViewModel {
  final LoadingStatus loadingStatus;
  final Function refresh;
  final bool isLoggedIn;
  final LandingPageViewModel landingPageViewModel;

  StartupViewModel(this.loadingStatus, this.refresh, this.isLoggedIn, this.landingPageViewModel);
}