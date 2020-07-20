import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';

class LocaleSelectionViewModel implements RefreshableViewModel, LoadableViewModel {
  @override
  // TODO: implement refresh
  Function get refresh => throw UnimplementedError();

  @override
  // TODO: implement loadingStatus
  LoadingStatus get loadingStatus => throw UnimplementedError();

}