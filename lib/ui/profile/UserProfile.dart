import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profile/UserProfileListItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final TextStyle detailTextStyle;
  final TextStyle buttonTextStyle;

  final double buttonHeight;
  final double imageSize;

  final int maxLines;

  const UserProfileStyle({
    this.buttonColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.detailTextStyle,
    this.buttonTextStyle,
    this.buttonHeight,
    this.imageSize,
    this.maxLines,
  });

  UserProfileStyle copyWith({
    Color buttonColor,
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    TextStyle detailTextStyle,
    TextStyle buttonTextStyle,
    double buttonHeight,
    double imageSize,
    int maxLines,
  }) {
    return UserProfileStyle(
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

class _DefaultStyle extends UserProfileStyle {
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(context),
            _buildItemList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: _Constants.headerEdgePadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildMainTextView(context),
              SizedBox(width: _Constants.imageSpacing),
              _buildPlotImage(_viewModel.image),
            ],
          ),
        ),
        _buildButton(),
        SizedBox(height: _Constants.buttonLineSpace),
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

  Widget _buildMainTextView(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildUsername(),
          SizedBox(height: _Constants.subtitleLineSpace),
          Row(
            children: <Widget>[
              _buildActiveCrops(),
              SizedBox(width: _Constants.detailSpacing),
              _buildCompletedCrops(),
            ],
          ),
        ],
      ),
    );
  }

  Column _buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: _Constants.titleLineSpace,
          child: Text(_viewModel.username,
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

  Widget _buildActiveCrops() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _viewModel.activeCrops.toString(),
          style: _style.subtitleTextStyle,
        ),
        Text(
          _LocalisedStrings.activeCrops(),
          maxLines: _style.maxLines,
          overflow: TextOverflow.ellipsis,
          style: _style.detailTextStyle,
        ),
      ],
    );
  }

  Widget _buildCompletedCrops() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _viewModel.completedCrops.toString(),
          style: _style.subtitleTextStyle,
        ),
        Text(
          _LocalisedStrings.completedCrops(),
          maxLines: _style.maxLines,
          overflow: TextOverflow.ellipsis,
          style: _style.detailTextStyle,
        ),
      ],
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: _Constants.edgePadding,
      child: Column(
        children: <Widget>[
          RoundedButton(
            viewModel: RoundedButtonViewModel(
              title: _LocalisedStrings.buttonTitle(),
              onTap: () => _viewModel.switchProfileAction(),
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
