import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/profile/Profile.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileListItem.dart';

import '../StaticViewModelProvider.dart';
import '../Transformer.dart';
import 'PersonName.dart';

class SwitchProfileListItemViewModelTransformer
    extends ObjectTransformer<ProfileEntity, SwitchProfileListItemViewModel> {
  final Function _switch;
  final ProfileEntity _currentProfile;
  SwitchProfileListItemViewModelTransformer(this._switch, this._currentProfile);
  @override
  SwitchProfileListItemViewModel transform({ProfileEntity from}) {
    final profileViewModel = ProfileViewModel(loadingStatus: LoadingStatus.SUCCESS,initials: PersonName(from.name).initials,image: from.avatar);
    final avatarProvider = StaticViewModelProvider<ProfileViewModel>(profileViewModel);
    return SwitchProfileListItemViewModel(
      title: from.name,
      image: from.avatar,
      switchAction: () => _switch(from),
      avatarViewModelProvider: avatarProvider,
      isSelected: (from.uri == _currentProfile?.uri),
    );
  }
}
