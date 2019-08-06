import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileListItem.dart';

import '../Transformer.dart';

class SwitchProfileListItemViewModelTransformer
    extends ObjectTransformer<ProfileEntity, SwitchProfileListItemViewModel> {
  final Function _switch;
  final ProfileEntity _currentProfile;
  SwitchProfileListItemViewModelTransformer(this._switch, this._currentProfile);
  @override
  SwitchProfileListItemViewModel transform({ProfileEntity from}) {
    return SwitchProfileListItemViewModel(
      title: from.name,
      image: MockImageEntity().build().urlProvider,
      switchAction: () => _switch(from),
      isSelected: (from == _currentProfile),
    );
  }
}
