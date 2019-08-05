import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileListItem.dart';

import '../Transformer.dart';

class SwitchProfileListItemViewModelTransformer
    extends ObjectTransformer<ProfileEntity,SwitchProfileListItemViewModel> {
  @override
  SwitchProfileListItemViewModel transform({ProfileEntity from}) {
    return SwitchProfileListItemViewModel(title: from.name);
  }
}
