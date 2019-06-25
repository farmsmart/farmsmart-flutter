
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:redux/redux.dart';

class MyProfitLossViewModel {
  LoadingStatus loadingStatus;

  MyProfitLossViewModel({this.loadingStatus});

  static MyProfitLossViewModel fromStore(Store<AppState> store) {
    return MyProfitLossViewModel(loadingStatus: LoadingStatus.SUCCESS);
  }
}