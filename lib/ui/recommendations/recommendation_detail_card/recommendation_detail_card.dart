import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/common/rounded_button_stateful.dart';
import 'package:farmsmart_flutter/ui/common/rounded_image_overlay.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/recommendation_card_view_model.dart';
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
}

class RecommendationDetailCardStyle {
  final TextStyle titleTextStyle;
  final DogTagStyle subtitleTagStyle;
  final RoundedButtonStatefulStyle actionStyle;
  final EdgeInsets contentPadding;
  final BorderRadius imageRadius;
  final double imageSize;
  final BoxDecoration actionBoxDecoration;
  final Color imageOverlayColor;
  final double imageOverlayHeight;
  final double imageOverlayWidth;
  final String iconAssetOverlay;
  final Color imageAddedOverlayColor;

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
    this.iconAssetOverlay,
    this.imageAddedOverlayColor,
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
    String iconAssetOverlay,
    Color imageAddedOverlayColor,
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
      iconAssetOverlay: iconAssetOverlay ?? this.iconAssetOverlay,
      imageAddedOverlayColor:
          imageAddedOverlayColor ?? this.imageAddedOverlayColor,
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

  final RoundedButtonStatefulStyle actionStyle = defaultRoundedButtonStyle;

  static const defaultRoundedButtonStyle = RoundedButtonStatefulStyle(
    activeRoundedButtonStyle: const RoundedButtonStyle(
      backgroundColor: Color(0xff24d900),
      borderRadius: BorderRadius.all(Radius.circular(12)),
      buttonTextStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Color(0xffffffff),
      ),
      iconEdgePadding: 5,
      height: 45,
      width: double.infinity,
      buttonIconSize: null,
      iconButtonColor: Color(0xFFFFFFFF),
      buttonShape: BoxShape.rectangle,
    ),
    inactiveRoundedButtonStyle: const RoundedButtonStyle(
      backgroundColor: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.all(Radius.circular(12)),
      buttonTextStyle: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xff4c4e6e)),
      iconEdgePadding: 5,
      height: 45,
      width: double.infinity,
      buttonIconSize: null,
      iconButtonColor: Color(0xFFFFFFFF),
      buttonShape: BoxShape.rectangle,
    ),
  );

  final EdgeInsets contentPadding = const EdgeInsets.all(32.0);
  final BorderRadius imageRadius = const BorderRadius.all(Radius.circular(12));
  final double imageSize = 80;
  final Color imageOverlayColor = const Color(0x1924d900);
  final Color imageAddedOverlayColor = const Color(0x3325df0c);
  final double imageOverlayHeight = 26;
  final double imageOverlayWidth = 26;
  final String iconAssetOverlay = 'assets/icons/tick_large.png';

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
    String iconAssetOverlay,
    Color imageAddedOverlayColor,
  });
}

const RecommendationDetailCardStyle _defaultStyle = const _DefaultStyle();

class RecommendationDetailCard extends StatefulWidget {
  final RecommendationDetailCardStyle _style;
  final RecommendationCardViewModel _viewModel;

  RecommendationDetailCard({
    Key key,
    RecommendationCardViewModel viewModel,
    RecommendationDetailCardStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  _RecommendationDetailCardState createState() =>
      _RecommendationDetailCardState();
}

class _RecommendationDetailCardState extends State<RecommendationDetailCard> {
  bool isAddedState;

  @override
  void initState() {
    isAddedState = widget._viewModel.isAdded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: widget._style.contentPadding,
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
      decoration: isAddedState ? widget._style.actionBoxDecoration : null,
      child: RoundedButtonStateful(
        style: widget._style.actionStyle,
        viewModel: RoundedButtonStatefulViewModel(
          isActive: !isAddedState,
          roundedButtonViewModel: RoundedButtonViewModel(
            title: widget._viewModel.addActionText,
            onTap: () {
              _buildAddActionAndChangeStyle();
            },
          ),
        ),
      ),
    );
  }

  void _buildAddActionAndChangeStyle() {
    if (!isAddedState) {
      widget._viewModel.addAction();
    }
    setState(() {
      isAddedState = true;
    });
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
        width: widget._style.imageSize,
        height: widget._style.imageSize,
        child: RoundedImageOverlay(
          imageHeight: widget._style.imageSize,
          imageWidth: widget._style.imageSize,
          imageBorderRadius: widget._style.imageRadius,
          image: widget._viewModel.imageProvider,
          showOverlayIcon: isAddedState,
          overlayIconWidth: widget._style.imageOverlayWidth,
          overlayIcon: widget._style.iconAssetOverlay,
          overlayIconHeight: widget._style.imageOverlayWidth,
          overlayColor: isAddedState
              ? widget._style.imageAddedOverlayColor
              : widget._style.imageOverlayColor,
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
            widget._viewModel.title,
            style: widget._style.titleTextStyle,
            maxLines: _Constants.titleMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: _Constants.titleSpace,
          ),
          DogTag(
            viewModel: DogTagViewModel(title: widget._viewModel.subtitle),
            style: widget._style.subtitleTagStyle,
          ),
        ],
      ),
    );
  }
}
