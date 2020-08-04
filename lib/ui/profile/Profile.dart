import 'dart:io';

import 'package:farmsmart_flutter/model/analytics_interface.dart';
import 'package:farmsmart_flutter/model/bloc/ResetStateWidget.dart';
import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/bloc/chatFlow/CreateAccountFlow.dart';
import 'package:farmsmart_flutter/model/bloc/chatFlow/EditProfileFlow.dart';
import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/locale/locale_repository_interface.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/ui/common/InputAlert.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ProfileAvatar.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/common/image_picker.dart';
import 'package:farmsmart_flutter/ui/common/locale_selection.dart';
import 'package:farmsmart_flutter/ui/common/modal_navigator.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/common/webview.dart';
import 'package:farmsmart_flutter/ui/offline/OfflineDownloadPage.dart';
import 'package:farmsmart_flutter/ui/profile/FarmDetailsListItem.dart';
import 'package:farmsmart_flutter/ui/profile/ProfileListItem.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as ImagePickerLib;
import 'package:intl/intl.dart';
import 'package:share/share.dart';

import '../../country_flags.dart';
import 'FarmDetails.dart';
import 'SwitchProfileList.dart';

class _LocalisedStrings {
  static activeCrops() => Intl.message('In progress crops');

  static editFarmDetails() => Intl.message('Edit Farm Details');

  static completedCrops() => Intl.message('Completed');

  static buttonTitle() => Intl.message('Switch Profile');

  static switchLanguage() => Intl.message('Switch Language');

  static yourFarmDetails() => Intl.message('Your Farm Details');

  static createNewProfile() => Intl.message('Create New Profile');

  static inviteFriends() => Intl.message('Invite Friends');

  static privacyPolicy() => Intl.message('Privacy Policy');

  static termsOfUse() => Intl.message('Terms of use');

  static logout() => Intl.message('Logout');

  static removeProfile() => Intl.message('Remove Profile');

  static confirm() => Intl.message('Confirm');

  static cancel() => Intl.message('Cancel');

  static pickImageFromGallery() => Intl.message('Pick image from gallery');

  static takePictureFromCamera() => Intl.message('Take picture from camera');

  static renameProfile() => Intl.message('Rename profile');

  static username() => Intl.message('Username');

  static offlineSync() => Intl.message('Enable Offline Use');

  static shareText() =>
      Intl.message('Join to the new smart farming app - FarmSmart \n');
}

class _Strings {
  static final privacyPolicyUrl =
      'https://sites.google.com/farmsmart.co/farmsmart/home/privacy-policy?authuser=0';
  static final termsOfUseUrl =
      'https://sites.google.com/farmsmart.co/farmsmart/home/privacy-policy?authuser=0';
  static final shareLink =
      'https://play.google.com/store/apps/details?id=co.farmsmart.app';
}

class _Icons {
  static final language = 'assets/icons/detail_icon_language.png';
  static final soil = 'assets/icons/detail_icon_best_soil.png';
  static final newProfile = 'assets/icons/detail_icon_new_profile.png';
  static final inviteFriends = 'assets/icons/detail_icon_invite.png';
  static final checkBoxIcon = "assets/icons/radio_button_default.png";
  static final downloadIcon =  "assets/icons/detail_icon_sale.png";
}

class _AnalyticsNames {
  static const switchProfileInteraction = 'switch_profile';
  static const switchLanguageInteraction = 'switch_lanaguage';
  static const editProfileInteraction = 'edit_profile';
  static const createNewProfileInteraction = 'create_profile';
  static const inviteFriendsInteraction = 'invite_friends';
  static const privacyPolicyInteraction = 'privacy_policy';
  static const termsOfUseInteraction = 'terms';
  static const renameProfileInteraction = 'rename_profile';
}

class _Constants {
  static final Color dividerColor = const Color(0xffe9eaf2);

  static final EdgeInsets edgePadding =
      const EdgeInsets.symmetric(horizontal: 32);
  static final EdgeInsets headerEdgePadding = const EdgeInsets.only(
    left: 32.0,
    top: 26.0,
    right: 32.0,
    bottom: 25.0,
  );
  static final EdgeInsets titleLineSpace = const EdgeInsets.only(bottom: 2);

  static final BorderRadius buttonBorderShape = const BorderRadius.all(
    Radius.circular(8),
  );

  static final double imageSpacing = 20;
  static final double subtitleLineSpace = 6.5;
  static final double buttonLineSpace = 25;
  static final double dividerHeight = 2;
  static final double detailSpacing = 23;
  static final int avatarImageSize = 200;
}

class _Fields {
  static final title = "title";
  static final value = "value";
}

class ProfileViewModel implements RefreshableViewModel, LoadableViewModel {
  final String username;
  final String initials;
  final int activeCrops;
  final int completedCrops;
  final ViewModelProvider<SwitchProfileListViewModel> switchProfileProvider;
  final ImageURLProvider image;
  final Function refresh;
  final Function logout;
  final Function remove;
  final Function(String) renameProfile;
  final LoadingStatus loadingStatus;
  final Map<String, Map<String, String>> farmDetails;
  final Function(String, String) switchLanguageTapped;
  final NewAccountFlowCoordinator newAccountFlow;
  final Function(File) saveProfileImage;
  EditProfileFlowCoordinator editProfileFlow;
  final List<ContentLocale> supportedLocales;
  final ContentLocale currentLocale;
  final ViewModelProvider<OfflineDownloadPageViewModel> downloaderViewModelProvider;

  ProfileViewModel({
    this.loadingStatus,
    this.username,
    this.initials,
    this.activeCrops,
    this.completedCrops,
    this.switchProfileProvider,
    this.image,
    this.refresh,
    this.logout,
    this.remove,
    this.farmDetails,
    this.switchLanguageTapped,
    this.newAccountFlow,
    this.saveProfileImage,
    this.renameProfile,
    this.editProfileFlow,
    this.supportedLocales,
    this.currentLocale,
    this.downloaderViewModelProvider,
  });
}

class ProfileStyle {
  final Color buttonColor;

  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final TextStyle detailTextStyle;
  final TextStyle buttonTextStyle;

  final double buttonHeight;
  final double imageSize;

  final int maxLines;

  const ProfileStyle({
    this.buttonColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.detailTextStyle,
    this.buttonTextStyle,
    this.buttonHeight,
    this.imageSize,
    this.maxLines,
  });

  ProfileStyle copyWith({
    Color buttonColor,
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    TextStyle detailTextStyle,
    TextStyle buttonTextStyle,
    double buttonHeight,
    double imageSize,
    int maxLines,
  }) {
    return ProfileStyle(
      buttonColor: buttonColor ?? this.buttonColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      detailTextStyle: detailTextStyle ?? this.detailTextStyle,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      imageSize: imageSize ?? this.imageSize,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}

class _DefaultStyle extends ProfileStyle {
  final Color buttonColor = const Color(0xffe9eaf2);

  final TextStyle titleTextStyle = const TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: Color(0xff1a1b46),
  );

  final TextStyle subtitleTextStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: Color(0xff4c4e6e),
  );

  final TextStyle detailTextStyle = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: Color(0xffb7b8c9),
  );

  final TextStyle buttonTextStyle = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Color(0xff4c4e6e),
  );

  final double buttonHeight = 40;
  final double imageSize = 72;

  final int maxLines = 1;

  const _DefaultStyle({
    Color buttonColor,
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    TextStyle detailTextStyle,
    TextStyle buttonTextStyle,
    double buttonHeight,
    double imageSize,
    int maxLines,
  });
}

const ProfileStyle _defaultStyle = const _DefaultStyle();

class Profile extends StatelessWidget {
  final ViewModelProvider<ProfileViewModel> _viewModelProvider;
  final ProfileStyle _style;

  const Profile({
    Key key,
    ViewModelProvider<ProfileViewModel> provider,
    ProfileStyle style = _defaultStyle,
  })  : this._viewModelProvider = provider,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProviderBuilder(
      provider: _viewModelProvider,
      successBuilder: _buildPage,
    );
  }

  Widget _buildPage({
    BuildContext context,
    AsyncSnapshot<ProfileViewModel> snapshot,
  }) {
    final viewModel = snapshot.data;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(context, viewModel),
            _buildItemList(viewModel, context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProfileViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        ActionSheet.present(_optionsMenu(viewModel, context), context);
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: _Constants.headerEdgePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildMainTextView(context, viewModel),
                SizedBox(width: _Constants.imageSpacing),
                _buildProfileImage(viewModel, context),
              ],
            ),
          ),
          _buildButton(context, viewModel),
          SizedBox(height: _Constants.buttonLineSpace),
        ],
      ),
    );
  }

  Widget _buildItemList(ProfileViewModel viewModel, BuildContext context) {
    var profileItems = _profileItems(viewModel, context);

    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: profileItems.length,
      itemBuilder: (context, index) => ProfileListItem(
        viewModel: profileItems[index],
      ),
      separatorBuilder: (context, index) => ListDivider.build(),
    );
  }

  Widget _buildMainTextView(BuildContext context, ProfileViewModel viewModel) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildUsername(viewModel),
          SizedBox(height: _Constants.subtitleLineSpace),
          Row(
            children: <Widget>[
              _buildActiveCrops(viewModel),
              SizedBox(width: _Constants.detailSpacing),
              _buildCompletedCrops(viewModel),
            ],
          ),
        ],
      ),
    );
  }

  Column _buildUsername(ProfileViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: _Constants.titleLineSpace,
          child: Text(viewModel.username,
              maxLines: _style.maxLines,
              overflow: TextOverflow.ellipsis,
              style: _style.titleTextStyle),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _Constants.dividerColor,
                width: _Constants.dividerHeight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveCrops(ProfileViewModel viewModel) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            viewModel.activeCrops.toString(),
            style: _style.subtitleTextStyle,
          ),
          Text(
            _LocalisedStrings.activeCrops(),
            maxLines: _style.maxLines,
            overflow: TextOverflow.ellipsis,
            style: _style.detailTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedCrops(ProfileViewModel viewModel) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            viewModel.completedCrops.toString(),
            style: _style.subtitleTextStyle,
          ),
          Text(
            _LocalisedStrings.completedCrops(),
            maxLines: _style.maxLines,
            overflow: TextOverflow.ellipsis,
            style: _style.detailTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, ProfileViewModel viewModel) {
    return Padding(
      padding: _Constants.edgePadding,
      child: Column(
        children: <Widget>[
          RoundedButton(
            viewModel: RoundedButtonViewModel(
              title: _LocalisedStrings.buttonTitle(),
              onTap: () => _tappedSwitchProfile(
                  context: context, provider: viewModel.switchProfileProvider),
            ),
            style: RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
              backgroundColor: _style.buttonColor,
              height: _style.buttonHeight,
              borderRadius: _Constants.buttonBorderShape,
              buttonTextStyle: _style.buttonTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(ProfileViewModel viewModel, BuildContext context) {
    return ProfileAvatar(
      viewModelProvider: _viewModelProvider,
      width: _style.imageSize,
      height: _style.imageSize,
    );
  }

  void _tappedSwitchProfile({
    BuildContext context,
    ViewModelProvider<SwitchProfileListViewModel> provider,
  }) {
    AnalyticsInterface.implementation().interaction(_AnalyticsNames.switchProfileInteraction);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SwitchProfileList(provider: provider),
        settings: RouteSettings(name:SwitchProfileList.analyticsName),
      ),
    );
  }

  List<ProfileListItemViewModel> _profileItems(
    ProfileViewModel viewModel,
    BuildContext context,
  ) {
    List<ProfileListItemViewModel> items = [];

    items.add(ProfileListItemViewModel(
      title: _LocalisedStrings.switchLanguage(),
      icon: _Icons.language,
      onTap: () => _switchLanguage(context, viewModel),
      isDestructive: false,
    ));

    items.add(ProfileListItemViewModel(
      title: _LocalisedStrings.offlineSync(),
      icon: _Icons.downloadIcon,
      onTap: () => _showOffline(context, viewModel),
      isDestructive: false,
    ));

    items.add(ProfileListItemViewModel(
      title: _LocalisedStrings.yourFarmDetails(),
      icon: _Icons.soil,
      onTap: () => _openFarmDetails(viewModel, context),
      isDestructive: false,
    ));

    items.add(ProfileListItemViewModel(
      title: _LocalisedStrings.inviteFriends(),
      icon: _Icons.inviteFriends,
      onTap: () => _inviteFriends(context),
      isDestructive: false,
    ));

    items.add(ProfileListItemViewModel(
      title: _LocalisedStrings.createNewProfile(),
      icon: _Icons.newProfile,
      onTap: () => _createNewProfile(viewModel, context),
      isDestructive: false,
    ));

    items.add(ProfileListItemViewModel(
      title: _LocalisedStrings.privacyPolicy(),
      icon: null,
      onTap: () => _openPrivacyPolicy(context),
      isDestructive: false,
    ));

    items.add(ProfileListItemViewModel(
      title: _LocalisedStrings.termsOfUse(),
      icon: null,
      onTap: () => _openTermsOfUse(context),
      isDestructive: false,
    ));

    if (viewModel.remove != null) {
      items.add(ProfileListItemViewModel(
        title: _LocalisedStrings.removeProfile(),
        icon: null,
        onTap: () => viewModel.remove(),
        isDestructive: true,
      ));
    }

    items.add(ProfileListItemViewModel(
      title: _LocalisedStrings.logout(),
      icon: null,
      onTap: () => viewModel.logout(),
      isDestructive: true,
    ));
    return items;
  }

  void _switchLanguage(BuildContext context, ProfileViewModel viewModel) {
    AnalyticsInterface.implementation().interaction(_AnalyticsNames.switchLanguageInteraction);
    LocaleSelection.present(context);
    //ActionSheet.present(_languageMenu(context,viewModel), context);
  }

  void _openFarmDetails(ProfileViewModel viewModel, BuildContext context) {
    NavigationScope.presentModal(
      context,
      FarmDetails(
        viewModel: FarmDetailsViewModel(
          removeProfile: viewModel.remove,
          editProfile: () => _editProfile(viewModel, context),
          items: _mapToFarmItemViewModel(viewModel.farmDetails),
          buttonTitle: _LocalisedStrings.editFarmDetails(),
          confirm: () {
            _editProfile(viewModel, context);
          },
        ),
      ),
    );
  }

  void _editProfile(ProfileViewModel viewModel, BuildContext context) {
    AnalyticsInterface.implementation().interaction(_AnalyticsNames.editProfileInteraction);
    return viewModel.editProfileFlow.run(
          context,
          onSuccess: () => _onEditProfileSuccess(context),
        );
  }

  void _createNewProfile(ProfileViewModel viewModel, BuildContext context) {
    AnalyticsInterface.implementation().interaction(_AnalyticsNames.createNewProfileInteraction);
    viewModel.newAccountFlow.run(context);
  }

  void _inviteFriends(BuildContext context) async {
     AnalyticsInterface.implementation().interaction(_AnalyticsNames.inviteFriendsInteraction);
    await Share.share('${_LocalisedStrings.shareText()} ${_Strings.shareLink}');
  }

  void _openPrivacyPolicy(BuildContext context) {
    AnalyticsInterface.implementation().interaction(_AnalyticsNames.privacyPolicyInteraction);
    _navigateToWebView(context, _Strings.privacyPolicyUrl);
  }

  void _openTermsOfUse(BuildContext context) {
     AnalyticsInterface.implementation().impression(_AnalyticsNames.termsOfUseInteraction);
    _navigateToWebView(context, _Strings.termsOfUseUrl);
  }

  List<FarmDetailsListItemViewModel> _mapToFarmItemViewModel(
      Map<String, Map<String, String>> farmDetails) {
    return farmDetails.entries.map(
      (MapEntry mapEntry) {
        return FarmDetailsListItemViewModel(
          title: (mapEntry.value as Map<String, String>)[_Fields.title],
          detail: (mapEntry.value as Map<String, String>)[_Fields.value],
        );
      },
    ).toList();
  }

  void _navigateToWebView(BuildContext context, String url) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebView(
          url: url,
        ),
      ),
    );
  }

  ActionSheet _languageMenu(BuildContext context, ProfileViewModel viewModel) {
    final actions = viewModel.supportedLocales.map((contentLocale) {
      final title =  getEmojiFlag(contentLocale.locale.countryCode) + ' ' + contentLocale.displayName;
      return ActionSheetListItemViewModel(
        title: title,
        type: ActionType.selectable,
        checkBoxIcon: _Icons.checkBoxIcon,
        isSelected: contentLocale.locale == viewModel.currentLocale.locale,
        onTap: () {
          viewModel.switchLanguageTapped(contentLocale.locale.languageCode, contentLocale.locale.countryCode);
          ResetStateWidget.resetState(context);
        }
      );
    }).toList();

    final actionSheetViewModel = ActionSheetViewModel(
      actions,
      _LocalisedStrings.cancel(),
      confirmButtonTitle: _LocalisedStrings.confirm(),
    );
    return ActionSheet(
      viewModel: actionSheetViewModel,
      style: ActionSheetStyle.defaultStyle(),
    );
  }

  ActionSheet _optionsMenu(ProfileViewModel viewModel, BuildContext context) {
    final actions = [
      ActionSheetListItemViewModel(
        title: _LocalisedStrings.takePictureFromCamera(),
        type: ActionType.simple,
        onTap: () => _pickImage(ImagePickerLib.ImageSource.camera, viewModel),
      ),
      ActionSheetListItemViewModel(
        title: _LocalisedStrings.pickImageFromGallery(),
        type: ActionType.simple,
        onTap: () => _pickImage(ImagePickerLib.ImageSource.gallery, viewModel),
      ),
      ActionSheetListItemViewModel(
        title: _LocalisedStrings.renameProfile(),
        type: ActionType.simple,
        onTap: () => _renameProfileAction(viewModel, context),
      ),
    ];

    final actionSheetViewModel = ActionSheetViewModel(
      actions,
      _LocalisedStrings.cancel(),
    );
    return ActionSheet(
      viewModel: actionSheetViewModel,
      style: ActionSheetStyle.defaultStyle(),
    );
  }

  void _renameProfileAction(ProfileViewModel viewModel, BuildContext context) {
    AnalyticsInterface.implementation().interaction(_AnalyticsNames.renameProfileInteraction);
    InputAlert.present(_renameInputAlert(viewModel), context);
  }

  InputAlert _renameInputAlert(ProfileViewModel viewModel) {
    return InputAlert(
      viewModel: InputAlertViewModel(
          initialValue: viewModel.username,
          cancelActionText: _LocalisedStrings.cancel(),
          confirmActionText: _LocalisedStrings.confirm(),
          titleText: _LocalisedStrings.renameProfile(),
          hint: _LocalisedStrings.username(),
          confirmInputAction: (value) {
            viewModel.renameProfile(value);
          }),
    );
  }

  _pickImage(
      ImagePickerLib.ImageSource imageSource, ProfileViewModel viewModel) {
    ImagePicker.pickImage(
      onSuccess: (file) {
        viewModel.saveProfileImage(file);
      },
      onCancel: (message) {
        //ignore
      },
      imageSource: imageSource,
      imageMaxHeight: _Constants.avatarImageSize,
      imageMaxWidth: _Constants.avatarImageSize,
    );
  }

  _showOffline(BuildContext context, ProfileViewModel viewModel){
    final offlinePage = OfflineDownloadPage(provider: viewModel.downloaderViewModelProvider);
    OfflineDownloadPage.present(offlinePage, context);
  }

  _onEditProfileSuccess(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
    _openFarmDetails(_viewModelProvider.snapshot(), context);
  }
}
