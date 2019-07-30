import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profile/UserProfileListItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Strings {
  static final String activeCrops = "Active crops";
  static final String completedCrops = "Completed";
  static final String buttonTitle = "Switch Profile";
}

class UserProfileViewModel {
  List<UserProfileListItemViewModel> items;
  String username;
  int activeCrops;
  int completedCrops;
  final Function switchProfileAction;
  ImageProvider image;

  UserProfileViewModel({
    this.items,
    this.username,
    this.activeCrops,
    this.completedCrops,
    this.switchProfileAction,
    this.image,
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
  final EdgeInsets headerEdgePadding;
  final EdgeInsets titleLineSpace;

  final BorderRadius buttonBorderShape;

  final double imageSpacing;
  final double subtitleLineSpace;
  final double buttonLineSpace;
  final double detailSpacing;
  final double dividerHeight;
  final double buttonHeight;
  final double imageSize;
  final int maxLines;

  const UserProfileStyle({
    this.buttonColor,
    this.dividerColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.detailTextStyle,
    this.buttonTextStyle,
    this.edgePadding,
    this.headerEdgePadding,
    this.buttonBorderShape,
    this.titleLineSpace,
    this.imageSpacing,
    this.subtitleLineSpace,
    this.buttonLineSpace,
    this.detailSpacing,
    this.dividerHeight,
    this.buttonHeight,
    this.imageSize,
    this.maxLines,
  });

  UserProfileStyle copyWith({
    Color buttonColor,
    Color dividerColor,
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    TextStyle detailTextStyle,
    TextStyle buttonTextStyle,
    EdgeInsets edgePadding,
    EdgeInsets headerEdgePadding,
    EdgeInsets titleLineSpace,
    BorderRadius buttonBorderShape,
    double imageSpacing,
    double subtitleLineSpace,
    double buttonLineSpace,
    double detailSpacing,
    double dividerHeight,
    double buttonHeight,
    double imageSize,
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
      headerEdgePadding: headerEdgePadding ?? this.headerEdgePadding,
      buttonBorderShape: buttonBorderShape ?? this.buttonBorderShape,
      titleLineSpace: titleLineSpace ?? this.titleLineSpace,
      imageSpacing: imageSpacing ?? this.imageSpacing,
      subtitleLineSpace: subtitleLineSpace ?? this.subtitleLineSpace,
      buttonLineSpace: buttonLineSpace ?? this.buttonLineSpace,
      detailSpacing: detailSpacing ?? this.detailSpacing,
      dividerHeight: dividerHeight ?? this.dividerHeight,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      imageSize: imageSize ?? this.imageSize,
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
  final EdgeInsets headerEdgePadding = const EdgeInsets.only(
    left: 32.0,
    top: 26.0,
    right: 32.0,
    bottom: 25.0,
  );

  final EdgeInsets titleLineSpace = const EdgeInsets.only(bottom: 2);

  final BorderRadius buttonBorderShape = const BorderRadius.all(
    Radius.circular(8),
  );

  final double imageSpacing = 20;
  final double subtitleLineSpace = 6.5;
  final double buttonLineSpace = 25;
  final double dividerHeight = 2;
  final double detailSpacing = 23;
  final double buttonHeight = 40;
  final double imageSize = 72;

  final int maxLines = 1;

  const _DefaultStyle({
    Color buttonColor,
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    TextStyle detailTextStyle,
    TextStyle buttonTextStyle,
    EdgeInsets edgePadding,
    EdgeInsets headerEdgePadding,
    BorderRadius buttonBorderShape,
    EdgeInsets titleLineSpace,
    double headerElevation,
    double imageSpacing,
    double subtitleLineSpace,
    double buttonLineSpace,
    double dividerHeight,
    double detailSpacing,
    double buttonHeight,
    double imageSize,
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildHeader(context),
          _buildItemList(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: _style.headerEdgePadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildMainTextView(context),
              SizedBox(width: _style.imageSpacing),
              _buildPlotImage(_viewModel.image),
            ],
          ),
        ),
        Padding(
          padding: _style.edgePadding,
          child: Column(
            children: <Widget>[
              RoundedButton(
                viewModel: RoundedButtonViewModel(
                  title: Intl.message(_Strings.buttonTitle),
                  onTap: () => _viewModel.switchProfileAction(),
                ),
                style: RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
                  backgroundColor: _style.buttonColor,
                  height: _style.buttonHeight,
                  borderRadius: _style.buttonBorderShape,
                  buttonTextStyle: _style.buttonTextStyle,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: _style.buttonLineSpace),
      ],
    );
  }

  Widget _buildItemList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: _viewModel.items.length,
      itemBuilder: (context, index) => UserProfileListItem(
        viewModel: _viewModel.items[index],
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: _style.titleLineSpace,
                child: Text(_viewModel.username,
                    maxLines: _style.maxLines,
                    overflow: TextOverflow.ellipsis,
                    style: _style.titleTextStyle),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _style.dividerColor,
                      width: _style.dividerHeight,
                    ),
                  ),
                ),
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
                    Intl.message(_Strings.activeCrops),
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
                    Intl.message(_Strings.completedCrops),
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

  ClipOval _buildPlotImage(ImageProvider image) {
    return ClipOval(
      child: Stack(
        children: <Widget>[
          Image(
            image: image,
            height: _style.imageSize,
            width: _style.imageSize,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ],
      ),
    );
  }
}
