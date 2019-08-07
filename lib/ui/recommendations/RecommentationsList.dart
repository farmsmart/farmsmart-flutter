import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:farmsmart_flutter/ui/common/SectionListView.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/crop/CropDetail.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_detail_card/recommendation_detail_card_styles.dart';
import 'package:farmsmart_flutter/ui/recommendations/viewmodel/RecommendationsListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'recommendation_card/recommendation_card.dart';
import 'recommendation_card/recommendation_card_styles.dart';
import 'recommendation_card/recommendation_card_view_model.dart';
import 'recommendation_compact_card/recommendation_compact_card.dart';
import 'recommendation_compact_card/recommendation_compact_card_styles.dart';
import 'recommendation_detail_card/recommendation_detail_card.dart';

class _LocalisedStrings {
  static String finish() => Intl.message('Finish');

  static String clearAction() => Intl.message('Clear Selection');

  static String cancelAction() => Intl.message('Cancel');
}

class _Constants {
  static const buttonPadding = EdgeInsets.all(24.0);
}

abstract class RecommendedListStyle {
  final TextStyle titleTextStyle;
  final EdgeInsets titleEdgePadding;
  final RoundedButtonStyle applyButtonStyle;

  RecommendedListStyle(
      this.titleTextStyle, this.titleEdgePadding, this.applyButtonStyle);

  RecommendedListStyle copyWith({
    TextStyle titleTextStyle,
    EdgeInsets titleEdgePadding,
  });
}

class _DefaultStyle implements RecommendedListStyle {
  final TextStyle titleTextStyle;
  final EdgeInsets titleEdgePadding;
  final RoundedButtonStyle applyButtonStyle;

  const _DefaultStyle(
      {TextStyle titleTextStyle,
      EdgeInsets titleEdgePadding,
      RoundedButtonStyle applyButtonStyle})
      : this.titleTextStyle = titleTextStyle ??
            const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a1b46),
            ),
        this.titleEdgePadding = titleEdgePadding ??
            const EdgeInsets.only(
              left: 34.0,
              right: 34.0,
              top: 35.0,
              bottom: 30.0,
            ),
        this.applyButtonStyle = applyButtonStyle ??
            const RoundedButtonStyle(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              backgroundColor: Color(0xff24d900),
              buttonTextStyle: TextStyle(
                color: Color(0xffffffff),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
              iconEdgePadding: 5,
              height: 56,
              width: double.infinity,
              buttonIconSize: null,
              iconButtonColor: Color(0xFFFFFFFF),
              buttonShape: BoxShape.rectangle,
            );

  @override
  RecommendedListStyle copyWith({
    TextStyle titleTextStyle,
    EdgeInsets titleEdgePadding,
  }) {
    return _DefaultStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        titleEdgePadding: titleEdgePadding ?? this.titleEdgePadding);
  }
}

const RecommendedListStyle _defaultStyle = const _DefaultStyle();

class RecommendationsList extends StatelessWidget implements ListViewSection {
  final RecommendedListStyle _style;
  final ViewModelProvider<RecommendationsListViewModel> _viewModelProvider;

  const RecommendationsList({
    Key key,
    ViewModelProvider<RecommendationsListViewModel> provider,
    RecommendedListStyle style = _defaultStyle,
  })  : this._style = style,
        this._viewModelProvider = provider,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProviderBuilder(
      provider: _viewModelProvider,
      successBuilder: _buildSuccess,
    );
  }

  @override
  itemBuilder() {
    final viewModel = _viewModelProvider.snapshot();
    return (BuildContext context, int index) {
      final itemViewModel = viewModel.items[index];
      final detailAction = () => _tappedDetail(
            context: context,
            provider: itemViewModel.detailProvider,
            recommendationCardViewModel: itemViewModel,
          );
      final item = itemViewModel.isHero
          ? RecommendationCard(
              viewModel: itemViewModel,
              detailAction: detailAction,
              style: RecommendationCardStyles.buildStyle(),
            )
          : RecommendationCompactCard(
              viewModel: itemViewModel,
              detailAction: detailAction,
              style: RecommendationCompactCardStyles.build(),
            );
      return item;
    };
  }

  @override
  int itemCount() {
    return _viewModelProvider.snapshot().items.length;
  }

  Widget _buildSuccess(
      {BuildContext context,
      AsyncSnapshot<RecommendationsListViewModel> snapshot}) {
    final viewModel = snapshot.data;
    if (viewModel.canApply) {
      return Scaffold(
        appBar: _buildAppBar(context, viewModel),
        body: _buildList(
          context: context,
          viewModel: viewModel,
        ),
        floatingActionButton:
            _buildApplyButton(context: context, viewModel: viewModel),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }

    return Scaffold(
      appBar: _buildAppBar(context, viewModel),
      body: _buildList(
        context: context,
        viewModel: viewModel,
      ),
    );
  }

  void _applyAction(
      BuildContext context, RecommendationsListViewModel viewModel) {
    viewModel.apply();
    Navigator.of(context).pop();
  }

  Widget _buildAppBar(
      BuildContext context, RecommendationsListViewModel viewModel) {
    return ContextualAppBar(
      moreAction: () => _moreTapped(
        context: context,
        viewModel: viewModel,
      ),
    ).build(context);
  }

  Widget _buildList({
    BuildContext context,
    RecommendationsListViewModel viewModel,
  }) {
    final footerList = viewModel.canApply
        ? <Widget>[
            SizedBox(
              height: _style.applyButtonStyle.height,
            )
          ]
        : <Widget>[];
    final headedList = HeaderAndFooterListView(
      headers: <Widget>[_buildHeader(viewModel: viewModel)],
      footers: footerList,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: itemBuilder(),
      itemCount: itemCount(),
    );
    return headedList;
  }

  Widget _buildHeader({RecommendationsListViewModel viewModel}) {
    return Container(
      padding: _style.titleEdgePadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            viewModel.title,
            style: _style.titleTextStyle,
          )
        ],
      ),
    );
  }

  Widget _buildApplyButton({
    BuildContext context,
    RecommendationsListViewModel viewModel,
  }) {
    return Padding(
      padding: _Constants.buttonPadding,
      child: RoundedButton(
        viewModel: RoundedButtonViewModel(
            title: _LocalisedStrings.finish(),
            onTap: () => _applyAction(context, viewModel)),
        style: _style.applyButtonStyle,
      ),
    );
  }

  void _tappedDetail({
    BuildContext context,
    ViewModelProvider<CropDetailViewModel> provider,
    RecommendationCardViewModel recommendationCardViewModel,
  }) {

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CropDetail(
          provider: provider,
          header: RecommendationDetailCard(
            viewModel: recommendationCardViewModel,
            style: RecommendationDetailCardStyles.build(),
          ),
        ),
      ),
    );
  }

  ActionSheet _moreMenu(RecommendationsListViewModel viewModel) {
    final actions = [
      ActionSheetListItemViewModel(
        title: _LocalisedStrings.clearAction(),
        isDestructive: true,
        type: ActionType.simple,
        onTap: viewModel.clear,
      ),
    ];
    final actionSheetViewModel = ActionSheetViewModel(
      actions,
      _LocalisedStrings.cancelAction(),
    );
    return ActionSheet(
      viewModel: actionSheetViewModel,
      style: ActionSheetStyle.defaultStyle(),
    );
  }

  void _moreTapped({
    BuildContext context,
    RecommendationsListViewModel viewModel,
  }) {
    ActionSheet.present(_moreMenu(viewModel), context);
  }
}
