
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:redux/redux.dart';

class ProfitLossViewModel {
  LoadingStatus loadingStatus;

  ProfitLossViewModel({this.loadingStatus});

  static ProfitLossViewModel fromStore(Store<AppState> store) {
    return ProfitLossViewModel(loadingStatus: LoadingStatus.SUCCESS);
  }
}