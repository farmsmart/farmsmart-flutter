import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/model/ImageURLProvider.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/common/image_provider_view.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profile/ProfileListItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'SwitchProfileList.dart';

class _LocalisedStrings {
  static String activeCrops() => Intl.message('Active crops');
  static String completedCrops() => Intl.message('Completed');
  static String buttonTitle() => Intl.message('Switch Profile');
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
}

class ProfileViewModel implements RefreshableViewModel, LoadableViewModel {
  final List<ProfileListItemViewModel> items;
  final String username;
  final int activeCrops;
  final int completedCrops;
  final ViewModelProvider<SwitchProfileListViewModel> switchProfileProvider;
  final ImageURLProvider image;
  final Function refresh;
  final LoadingStatus loadingStatus;

  ProfileViewModel({
    this.loadingStatus,
    this.items,
    this.username,
    this.activeCrops,
    this.completedCrops,
    this.switchProfileProvider,
    this.image,
    this.refresh,
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

  Widget _buildPage(
      {BuildContext context, AsyncSnapshot<ProfileViewModel> snapshot}) {
    final viewModel = snapshot.data;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(context, viewModel),
            _buildItemList(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProfileViewModel viewModel) {
    return Column(
      children: <Widget>[
        Container(
          margin: _Constants.headerEdgePadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildMainTextView(context, viewModel),
              SizedBox(width: _Constants.imageSpacing),
              _buildProfileImage(viewModel.image),
            ],
          ),
        ),
        _buildButton(context, viewModel),
        SizedBox(height: _Constants.buttonLineSpace),
      ],
    );
  }

  Widget _buildItemList(ProfileViewModel viewModel) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: viewModel.items.length,
      itemBuilder: (context, index) => ProfileListItem(
        viewModel: viewModel.items[index],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          viewModel.activeCrops.toString(),
          style: _style.subtitleTextStyle,
        ),
        Text(
          Intl.message(_LocalisedStrings.activeCrops()),
          maxLines: _style.maxLines,
          overflow: TextOverflow.ellipsis,
          style: _style.detailTextStyle,
        ),
      ],
    );
  }

  Widget _buildCompletedCrops(ProfileViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          viewModel.completedCrops.toString(),
          style: _style.subtitleTextStyle,
        ),
        Text(
          Intl.message(_LocalisedStrings.completedCrops()),
          maxLines: _style.maxLines,
          overflow: TextOverflow.ellipsis,
          style: _style.detailTextStyle,
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, ProfileViewModel viewModel) {
    return Padding(
      padding: _Constants.edgePadding,
      child: Column(
        children: <Widget>[
          RoundedButton(
            viewModel: RoundedButtonViewModel(
              title: Intl.message(_LocalisedStrings.buttonTitle()),
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

  ClipOval _buildProfileImage(ImageURLProvider image) {
    return ClipOval(
      child: ImageProviderView(
        imageURLProvider: image,
        width: _style.imageSize,
        height: _style.imageSize,
      ),
    );
  }

  void _tappedSwitchProfile({
    BuildContext context,
    ViewModelProvider<SwitchProfileListViewModel> provider,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SwitchProfileList(provider: provider),
      ),
    );
  }
}
