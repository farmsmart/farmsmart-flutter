import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/common/rounded_button_stateful.dart';
import 'package:farmsmart_flutter/ui/common/rounded_image_overlay.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/recommendation_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

export 'package:farmsmart_flutter/ui/common/roundedButton.dart';

class _Constants {
  static String textDivider = ' - ';
  static EdgeInsets titlesPadding = const EdgeInsets.only(left: 21.0);
  static EdgeInsets descriptionPadding = const EdgeInsets.only(top: 10);
  static EdgeInsets actionsPadding = const EdgeInsets.only(top: 24);
  static double horizontalActionsSeparation = 12;
  static int titleFlex = 1;
  static int subtitleFlex = 1;
  static int titleMaxLines = 1;
  static int subtitleMaxLines = 1;
}

class RecommendationCompactCardStyle {
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final TextStyle descriptionTextStyle;
  final RoundedButtonStatefulStyle leftActionButtonStyle;
  final RoundedButtonStatefulStyle rightActionButtonStyle;
  final double imageHeight;
  final BorderRadiusGeometry imageBorderRadius;
  final int descriptionMaxLines;
  final EdgeInsets contentPadding;
  final BoxDecoration rightActionBoxDecoration;
  final Color overlayColor;
  final double overlayIconHeight;
  final double overlayIconWidth;
  final String overlayIcon;
  final Color addedOverlayColor;

  const RecommendationCompactCardStyle({
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.descriptionTextStyle,
    this.leftActionButtonStyle,
    this.rightActionButtonStyle,
    this.imageHeight,
    this.imageBorderRadius,
    this.descriptionMaxLines,
    this.contentPadding,
    this.rightActionBoxDecoration,
    this.overlayColor,
    this.overlayIconHeight,
    this.overlayIconWidth,
    this.overlayIcon,
    this.addedOverlayColor,
  });

  RecommendationCompactCardStyle copyWith({
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    TextStyle descriptionTextStyle,
    RoundedButtonStatefulStyle leftActionButtonStyle,
    RoundedButtonStatefulStyle rightActionButtonStyle,
    double imageHeight,
    BorderRadiusGeometry imageBorderRadius,
    int descriptionMaxLines,
    EdgeInsets contentPadding,
    BoxDecoration rightBoxDecoration,
    Color overlayColor,
    double overlayIconHeight,
    double overlayIconWidth,
    String overlayIcon,
    Color addedOverlayColor,
  }) {
    return RecommendationCompactCardStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      leftActionButtonStyle:
          leftActionButtonStyle ?? this.leftActionButtonStyle,
      rightActionButtonStyle:
          rightActionButtonStyle ?? this.rightActionButtonStyle,
      imageHeight: imageHeight ?? this.imageHeight,
      imageBorderRadius: imageBorderRadius ?? this.imageBorderRadius,
      descriptionMaxLines: descriptionMaxLines ?? this.descriptionMaxLines,
      contentPadding: contentPadding ?? this.contentPadding,
      rightActionBoxDecoration:
          rightBoxDecoration ?? this.rightActionBoxDecoration,
      overlayColor: overlayColor ?? this.overlayColor,
      overlayIconHeight: overlayIconHeight ?? this.overlayIconHeight,
      overlayIconWidth: overlayIconWidth ?? this.overlayIconWidth,
      overlayIcon: overlayIcon ?? this.overlayIcon,
      addedOverlayColor: addedOverlayColor ?? this.addedOverlayColor,
    );
  }
}

class _DefaultStyle extends RecommendationCompactCardStyle {
  final TextStyle titleTextStyle = const TextStyle(
    color: Color(0xff1a1b46),
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );
  final TextStyle subtitleTextStyle = const TextStyle(
    color: Color(0xff1a1b46),
    fontSize: 17,
  );
  final TextStyle descriptionTextStyle = const TextStyle(
    color: Color(0xff767690),
    fontSize: 14,
  );
  final RoundedButtonStatefulStyle leftActionButtonStyle =
      defaultRoundedButtonStyle;
  final RoundedButtonStatefulStyle rightActionButtonStyle =
      defaultRoundedButtonStyle;
  final double imageHeight = 80;
  final BorderRadiusGeometry imageBorderRadius =
      const BorderRadius.all(Radius.circular(12.0));
  final int descriptionMaxLines = 2;

  final EdgeInsets contentPadding = const EdgeInsets.all(32.0);

  final Color overlayColor = const Color(0x1924d900);
  final Color addedOverlayColor = const Color(0x3325df0c);
  final double overlayIconHeight = 26;
  final double overlayIconWidth = 26;

  final String overlayIcon = 'assets/icons/tick_large.png';

  static const defaultRoundedButtonStyle = RoundedButtonStatefulStyle(
    activeRoundedButtonStyle: const RoundedButtonStyle(
      backgroundColor: Color(0xff24d900),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      buttonTextStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xffffffff),
      ),
      iconEdgePadding: 5,
      height: 40,
      width: double.infinity,
      buttonIconSize: null,
      iconButtonColor: Color(0xFFFFFFFF),
      buttonShape: BoxShape.rectangle,
    ),
    inactiveRoundedButtonStyle: const RoundedButtonStyle(
      backgroundColor: Color(0xffe9eaf2),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      buttonTextStyle: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xff4c4e6e)),
      iconEdgePadding: 5,
      height: 40,
      width: double.infinity,
      buttonIconSize: null,
      iconButtonColor: Color(0xFFFFFFFF),
      buttonShape: BoxShape.rectangle,
    ),
  );

  const _DefaultStyle(
      {TextStyle titleTextStyle,
      TextStyle subtitleTextStyle,
      TextStyle descriptionTextStyle,
      RoundedButtonStyle leftActionButtonStyle,
      RoundedButtonStyle rightActionButtonStyle,
      double imageHeight,
      BorderRadiusGeometry imageBorderRadius,
      int descriptionMaxLines,
      EdgeInsets contentPadding,
      Color overlayColor,
      double overlayIconHeight,
      double overlayIconWidth,
      String overlayIcon});
}

const RecommendationCompactCardStyle _defaultStyle = const _DefaultStyle();

class RecommendationCompactCard extends StatelessWidget {
  final RecommendationCompactCardStyle _style;
  final RecommendationCardViewModel _viewModel;
  final Function _detailAction;

  RecommendationCompactCard({
    Key key,
    @required RecommendationCardViewModel viewModel,
    Function detailAction,
    RecommendationCompactCardStyle style = _defaultStyle,
  })  : this._style = style,
        this._viewModel = viewModel,
        this._detailAction = detailAction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: _style.contentPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTopContent(),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  _buildTopContent() {
    return Row(
      children: <Widget>[
        _buildTopRoundedImage(),
        _buildTexts(),
      ],
    );
  }

  Widget _buildTopRoundedImage() {
    return Container(
      width: _style.imageHeight,
      height: _style.imageHeight,
      child: RoundedImageOverlay(
        image: _viewModel.imageProvider,
        imageHeight: _style.imageHeight,
        imageWidth: _style.imageHeight,
        imageBorderRadius: _style.imageBorderRadius,
        overlayIcon: _style.overlayIcon,
        overlayIconHeight: _style.overlayIconHeight,
        overlayIconWidth: _style.overlayIconWidth,
        overlayColor:
            _viewModel.isAdded ? _style.addedOverlayColor : _style.overlayColor,
        showOverlayIcon: _viewModel.isAdded,
      ),
    );
  }

  _buildTexts() {
    return Expanded(
      child: Padding(
        padding: _Constants.titlesPadding,
        child: Column(
          children: <Widget>[
            _buildTitle(),
            _buildDescription(),
          ],
        ),
      ),
    );
  }

  _buildTitle() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: _Constants.titleFlex,
          child: Text(
            _viewModel.title,
            style: _style.titleTextStyle,
            maxLines: _Constants.titleMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          _Constants.textDivider,
          style: _style.subtitleTextStyle,
        ),
        Flexible(
          flex: _Constants.subtitleFlex,
          child: Text(
            _viewModel.subtitle,
            style: _style.subtitleTextStyle,
            maxLines: _Constants.subtitleMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  _buildDescription() {
    return Padding(
      padding: _Constants.descriptionPadding,
      child: Text(
        _viewModel.description,
        style: _style.descriptionTextStyle,
        maxLines: _style.descriptionMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _buildActions() {
    return Padding(
      padding: _Constants.actionsPadding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: RoundedButtonStateful(
              style: _style.leftActionButtonStyle,
              viewModel: RoundedButtonStatefulViewModel(
                roundedButtonViewModel: RoundedButtonViewModel(
                  title: _viewModel.detailActionText,
                  onTap: _detailAction,
                ),
              ),
            ),
          ),
          SizedBox(
            width: _Constants.horizontalActionsSeparation,
          ),
          Expanded(
            child: Container(
              decoration:
                  _viewModel.isAdded ? _style.rightActionBoxDecoration : null,
              child: RoundedButtonStateful(
                style: _style.rightActionButtonStyle,
                viewModel: RoundedButtonStatefulViewModel(
                  isActive: !_viewModel.isAdded,
                  roundedButtonViewModel: RoundedButtonViewModel(
                    title: _viewModel.addActionText,
                    onTap: _viewModel.addAction,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
