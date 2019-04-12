import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:redux/redux.dart';

class HomeViewmodel {
  LoadingStatus loadingStatus;

  HomeViewmodel(
      {this.loadingStatus});

  static HomeViewmodel fromStore(Store<AppState> store) {
    return HomeViewmodel(
        loadingStatus: store.state.homeState.loadingStatus
    );
  }
}