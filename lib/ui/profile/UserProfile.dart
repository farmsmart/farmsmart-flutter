import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profile/UserProfileListItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Constants {
  // TODO: temporal image link
  static final link =
      "https://www.flower-pepper.com/wp-content/uploads/2016/10/Kermit-the-Frog-by-Bartholomew-300x378.jpg";

  static final List<UserProfileListItemViewModel> PROFILE_ACTIONS = [
    UserProfileListItemViewModel(
      title: Intl.message("Switch Language"),
      icon: "assets/icons/detail_icon_language.png",
      isDestructive: false,
    ),
    UserProfileListItemViewModel(
      title: Intl.message("Your Farm Details"),
      icon: "assets/icons/detail_icon_best_soil.png",
      isDestructive: false,
    ),
    UserProfileListItemViewModel(
      title: Intl.message("Update Pin"),
      icon: "assets/icons/detail_icon_pin.png",
      isDestructive: false,
    ),
    UserProfileListItemViewModel(
      title: Intl.message("Create New Profile"),
      icon: "assets/icons/detail_icon_new_profile.png",
      isDestructive: false,
    ),
    UserProfileListItemViewModel(
      title: Intl.message("Invite Friends"),
      icon: "assets/icons/detail_icon_invite.png",
      isDestructive: false,
    ),
    UserProfileListItemViewModel(
      title: Intl.message("Privacy Policy"),
      isDestructive: false,
    ),
    UserProfileListItemViewModel(
      title: Intl.message("Terms of User"),
      isDestructive: false,
    ),
    UserProfileListItemViewModel(
      title: Intl.message("Delete Profile"),
      isDestructive: true,
    ),
  ];
}

class _Strings {
  static final String ACTIVE_CROPS = Intl.message("Active crops");
  static final String COMPLETED = Intl.message("Completed");
  static final String SWITCH_PROFILE = Intl.message("Switch Profile");
}

class UserProfileViewModel {
  String userName;
  int activeCrops;
  int completedCrops;
  String buttonTitle;
  final Future<String> imageUrl;

  UserProfileViewModel({
    this.userName,
    this.activeCrops,
    this.completedCrops,
    this.buttonTitle,
    this.imageUrl,
  });
}

class UserProfileStyle {
  final Color buttonColor;
  final Color dividerColor;

  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final TextStyle detailTextStyle;
  final TextStyle buttonTextStyle;

  final EdgeInsets edgePadding;
  final EdgeInsets cardEdgePadding;
  final EdgeInsets headerEdgePadding;

  final double headerElevation;
  final double titleLineSpace;
  final double imageSpacing;
  final double subtitleLineSpace;
  final double buttonLineSpace;

  final double detailSpacing;
  final double dividerHeight;
  final double dividerWidth;

  final double buttonHeight;
  final int maxLines;

  const UserProfileStyle(
      {this.buttonColor,
      this.dividerColor,
      this.titleTextStyle,
      this.subtitleTextStyle,
      this.detailTextStyle,
      this.buttonTextStyle,
      this.edgePadding,
      this.cardEdgePadding,
      this.headerEdgePadding,
      this.headerElevation,
      this.titleLineSpace,
      this.imageSpacing,
      this.subtitleLineSpace,
      this.buttonLineSpace,
      this.detailSpacing,
      this.dividerHeight,
      this.dividerWidth,
      this.buttonHeight,
      this.maxLines});

  UserProfileStyle copyWith({
    Color buttonColor,
    Color dividerColor,
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    TextStyle detailTextStyle,
    TextStyle buttonTextStyle,
    EdgeInsets edgePadding,
    EdgeInsets cardEdgePadding,
    EdgeInsets headerEdgePadding,
    double headerElevation,
    double titleLineSpace,
    double imageSpacing,
    double subtitleLineSpace,
    double buttonLineSpace,
    double detailSpacing,
    double dividerHeight,
    double dividerWidth,
    double buttonHeight,
    int maxLines,
  }) {
    return UserProfileStyle(
      buttonColor: buttonColor ?? this.buttonColor,
      dividerColor: dividerColor ?? this.dividerColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      detailTextStyle: detailTextStyle ?? this.detailTextStyle,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      edgePadding: edgePadding ?? this.edgePadding,
      cardEdgePadding: cardEdgePadding ?? this.cardEdgePadding,
      headerEdgePadding: headerEdgePadding ?? this.headerEdgePadding,
      headerElevation: headerElevation ?? this.headerElevation,
      titleLineSpace: titleLineSpace ?? this.titleLineSpace,
      imageSpacing: imageSpacing ?? this.imageSpacing,
      subtitleLineSpace: subtitleLineSpace ?? this.subtitleLineSpace,
      buttonLineSpace: buttonLineSpace ?? this.buttonLineSpace,
      detailSpacing: detailSpacing ?? this.detailSpacing,
      dividerHeight: dividerHeight ?? this.dividerHeight,
      dividerWidth: dividerWidth ?? this.dividerWidth,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}

class _DefaultStyle extends UserProfileStyle {
  final Color buttonColor = const Color(0xffe9eaf2);
  final Color dividerColor = const Color(0xffe9eaf2);

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

  final EdgeInsets edgePadding = const EdgeInsets.symmetric(horizontal: 32);
  final EdgeInsets cardEdgePadding = const EdgeInsets.all(0);
  final EdgeInsets headerEdgePadding = const EdgeInsets.only(
    left: 32.0,
    top: 27.0,
    right: 32.0,
    bottom: 25.0,
  );

  final double headerElevation = 0;
  final double titleLineSpace = 0.5;
  final double imageSpacing = 20;
  final double subtitleLineSpace = 6.5;
  final double buttonLineSpace = 25;
  final double dividerHeight = 2;
  final double dividerWidth = 121;
  final double detailSpacing = 23;
  final double buttonHeight = 40;

  final int maxLines = 1;

  const _DefaultStyle({
    Color buttonColor,
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    TextStyle detailTextStyle,
    TextStyle buttonTextStyle,
    EdgeInsets edgePadding,
    EdgeInsets cardEdgePadding,
    EdgeInsets headerEdgePadding,
    double headerElevation,
    double titleLineSpace,
    double imageSpacing,
    double subtitleLineSpace,
    double buttonLineSpace,
    double detailSpacing,
    double buttonHeight,
    int maxLines,
  });
}

const UserProfileStyle _defaultStyle = const _DefaultStyle();

class UserProfile extends StatelessWidget {
  final UserProfileViewModel _viewModel;
  final UserProfileStyle _style;

  const UserProfile({
    Key key,
    UserProfileViewModel viewModel,
    UserProfileStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  //TODO: Add profile actions
  @override
  Widget build(BuildContext context) {
    List<Function> listOfFunctions = [
      () => ActionSheet.onMenuPressed(context),
      () => showSnackBar("Action 2", context),
      () => showSnackBar("Action 3", context),
      () => showSnackBar("Action 4", context),
      () => showSnackBar("Action 5", context),
      () => showSnackBar("Action 6", context),
      () => showSnackBar("Action 7", context),
      () => showSnackBar("Action 8", context),
    ];

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildHeader(context),
          _buildListOfActions(_viewModel, listOfFunctions),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Card(
      margin: _style.cardEdgePadding,
      elevation: _style.headerElevation,
      child: Column(
        children: <Widget>[
          Container(
            margin: _style.headerEdgePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildMainTextView(context),
                SizedBox(width: _style.imageSpacing),
                _buildPlotImage(_Constants.link),
              ],
            ),
          ),
          Padding(
            padding: _style.edgePadding,
            child: Column(
              children: <Widget>[
                RoundedButton(
                  viewModel: RoundedButtonViewModel(
                      title: _Strings.SWITCH_PROFILE,
                      onTap: () => Navigator.pop(context)),
                  style: RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
                    backgroundColor: _style.buttonColor,
                    height: _style.buttonHeight,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    buttonTextStyle: _style.buttonTextStyle,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: _style.buttonLineSpace)
        ],
      ),
    );
  }

  Widget _buildListOfActions(
      UserProfileViewModel viewModel, List<Function> listOfFunctions) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: _Constants.PROFILE_ACTIONS.length,
      itemBuilder: (context, index) => UserProfileListItem(
            viewModel: UserProfileListItemViewModel(
                icon: _Constants.PROFILE_ACTIONS[index].icon,
                title: _Constants.PROFILE_ACTIONS[index].title,
                onTap: listOfFunctions[index],
                isDestructive: _Constants.PROFILE_ACTIONS[index].isDestructive),
          ),
      separatorBuilder: (context, index) => ListDivider.build(),
    );
  }

  _buildMainTextView(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_viewModel.userName,
                  maxLines: _style.maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: _style.titleTextStyle),
              SizedBox(height: _style.titleLineSpace),
              Container(
                height: _style.dividerHeight,
                //width: double.infinity,
                color: _style.dividerColor,
              ),
            ],
          ),
          SizedBox(height: _style.subtitleLineSpace),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _viewModel.activeCrops.toString(),
                    style: _style.subtitleTextStyle,
                  ),
                  Text(
                    _Strings.ACTIVE_CROPS,
                    maxLines: _style.maxLines,
                    overflow: TextOverflow.ellipsis,
                    style: _style.detailTextStyle,
                  ),
                ],
              ),
              SizedBox(width: _style.detailSpacing),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _viewModel.completedCrops.toString(),
                    style: _style.subtitleTextStyle,
                  ),
                  Text(
                    _Strings.COMPLETED,
                    maxLines: _style.maxLines,
                    overflow: TextOverflow.ellipsis,
                    style: _style.detailTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ClipOval _buildPlotImage(String imageUrl) {
    return ClipOval(
        child: Stack(children: <Widget>[
      Image.network(
        imageUrl,
        height: 72,
        width: 72,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    ]));
  }

/*
  ClipOval _buildPlotImage(
      Future<String> imageUrl, PlotListItemStyle itemStyle) {
    return ClipOval(
        child: Stack(children: <Widget>[
          NetworkImageFromFuture(imageUrl,
              height: itemStyle.imageSize,
              width: itemStyle.imageSize,
              fit: BoxFit.cover),
          Positioned.fill(
              child: Container(
                color: itemStyle.overlayColor,
              )),
        ]));
  } */

  void showSnackBar(String text, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 350),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
