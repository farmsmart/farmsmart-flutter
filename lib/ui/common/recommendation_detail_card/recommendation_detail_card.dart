import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/common/rounded_image_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

export 'package:farmsmart_flutter/ui/common/Dogtag.dart';
export 'package:farmsmart_flutter/ui/common/roundedButton.dart';

class _Constants {
  static final int titleFlexValue = 3;
  static final int imageFlexValue = 2;
  static final int titleMaxLines = 1;
  static final double titleSpace = 12;
  static final double actionSpace = 36;
  static final double imageSize = 100;
  static final BorderRadius imageRadius =
      const BorderRadius.all(Radius.circular(12));
}

class RecommendationDetailCardViewModel {
  String title;
  String subtitle;
  ImageProvider image;
  String actionText;
  Function action;
  bool isAdded;
  String iconAssetOverlay;

  RecommendationDetailCardViewModel({
    this.title,
    this.subtitle,
    this.actionText,
    this.action,
    this.image,
    this.isAdded = false,
    this.iconAssetOverlay,
  });
}

class RecommendationDetailCardStyle {
  final TextStyle titleTextStyle;
  final DogTagStyle subtitleTagStyle;
  final RoundedButtonStyle actionStyle;
  final EdgeInsets contentPadding;
  final BorderRadius imageRadius;
  final double imageSize;
  final BoxDecoration actionBoxDecoration;
  final Color imageOverlayColor;
  final double imageOverlayHeight;
  final double imageOverlayWidth;

  const RecommendationDetailCardStyle({
    this.titleTextStyle,
    this.subtitleTagStyle,
    this.actionStyle,
    this.contentPadding,
    this.imageRadius,
    this.imageSize,
    this.actionBoxDecoration,
    this.imageOverlayColor,
    this.imageOverlayHeight,
    this.imageOverlayWidth,
  });

  RecommendationDetailCardStyle copyWith({
    TextStyle titleTextStyle,
    TextStyle subtitleTagStyle,
    RoundedButtonStyle actionStyle,
    EdgeInsets contentPadding,
    BorderRadius imageRadius,
    double imageSize,
    BoxDecoration actionBoxDecoration,
    Color imageOverlayColor,
    double imageOverlayHeight,
    double imageOverlayWidth,
  }) {
    return RecommendationDetailCardStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTagStyle: subtitleTagStyle ?? this.subtitleTagStyle,
      actionStyle: actionStyle ?? this.actionStyle,
      contentPadding: contentPadding ?? this.contentPadding,
      imageRadius: imageRadius ?? this.imageRadius,
      imageSize: imageSize ?? this.imageSize,
      actionBoxDecoration: actionBoxDecoration ?? this.actionBoxDecoration,
      imageOverlayColor: imageOverlayColor ?? this.imageOverlayColor,
      imageOverlayHeight: imageOverlayHeight ?? this.imageOverlayHeight,
      imageOverlayWidth: imageOverlayHeight ?? this.imageOverlayHeight,
    );
  }
}

class _DefaultStyle extends RecommendationDetailCardStyle {
  final TextStyle titleTextStyle = const TextStyle(
    color: Color(0xff1a1b46),
    fontSize: 27,
    fontWeight: FontWeight.bold,
  );

  final DogTagStyle subtitleTagStyle = const DogTagStyle(
    backgroundColor: Color(0x1624d900),
    titleTextStyle: TextStyle(
        color: Color(0xff21c400), fontSize: 11, fontWeight: FontWeight.w500),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    edgePadding: EdgeInsets.only(top: 8.5, right: 12, left: 12, bottom: 8),
    maxLines: 1,
    iconSize: 8,
    spacing: 5.5,
  );

  final RoundedButtonStyle actionStyle = const RoundedButtonStyle(
    backgroundColor: Color(0xff24d900),
    borderRadius: BorderRadius.all(Radius.circular(12)),
    buttonTextStyle: TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    iconEdgePadding: 5,
    height: 45,
    width: double.infinity,
    buttonIconSize: null,
    iconButtonColor: Color(0xFFFFFFFF),
    buttonShape: BoxShape.rectangle,
  );

  final EdgeInsets contentPadding = const EdgeInsets.all(32.0);
  final BorderRadius imageRadius = const BorderRadius.all(Radius.circular(12));
  final double imageSize = 80;
  final Color imageOverlayColor = const Color(0x1924d900);
  final double imageOverlayHeight = 26;
  final double imageOverlayWidth = 26;

  const _DefaultStyle({
    TextStyle titleTextStyle,
    DogTagStyle subtitleTagStyle,
    RoundedButtonStyle actionStyle,
    EdgeInsets contentPadding,
    BorderRadius imageRadius,
    double imageSize,
    Color imageOverlayColor,
    double imageOverlayHeight,
    double imageOverlayWidth,
  });
}

const RecommendationDetailCardStyle _defaultStyle = const _DefaultStyle();

class RecommendationDetailCard extends StatelessWidget {
  final RecommendationDetailCardStyle _style;
  final RecommendationDetailCardViewModel _viewModel;

  RecommendationDetailCard({
    Key key,
    RecommendationDetailCardViewModel viewModel,
    RecommendationDetailCardStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: _style.contentPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildTopContent(),
            buildActionSpacer(),
            buildActionButton()
          ],
        ),
      ),
    );
  }

  SizedBox buildActionSpacer() {
    return SizedBox(
      height: _Constants.actionSpace,
    );
  }

  Container buildActionButton() {
    return Container(
      decoration: _style.actionBoxDecoration,
      child: RoundedButton(
        viewModel: RoundedButtonViewModel(
          title: _viewModel.actionText,
          onTap: _viewModel.action,
        ),
        style: _style.actionStyle,
      ),
    );
  }

  Row buildTopContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTitleAndSubtitle(),
        buildRoundedImage(),
      ],
    );
  }

  Flexible buildRoundedImage() {
    return Flexible(
      flex: _Constants.imageFlexValue,
      child: Container(
        width: _style.imageSize,
        height: _style.imageSize,
        child: RoundedImageOverlay(
          imageHeight: _style.imageSize,
          imageWidth: _style.imageSize,
          imageBorderRadius: _style.imageRadius,
          image: _viewModel.image,
          showOverlay: _viewModel.isAdded,
          overlayIconWidth: _style.imageOverlayWidth,
          overlayIcon: _viewModel.iconAssetOverlay,
          overlayIconHeight: _style.imageOverlayWidth,
          overlayColor: _style.imageOverlayColor,
        ),
      ),
    );
  }

  Expanded buildTitleAndSubtitle() {
    return Expanded(
      flex: _Constants.titleFlexValue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            _viewModel.title,
            style: _style.titleTextStyle,
            maxLines: _Constants.titleMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: _Constants.titleSpace,
          ),
          DogTag(
            viewModel: DogTagViewModel(title: _viewModel.subtitle),
            style: _style.subtitleTagStyle,
          ),
        ],
      ),
    );
  }
}
