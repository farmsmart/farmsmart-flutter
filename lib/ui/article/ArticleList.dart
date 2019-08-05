import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/ui/article/ArticleDetail.dart';
import 'package:farmsmart_flutter/ui/article/HeroListItem.dart';
import 'package:farmsmart_flutter/ui/article/StandardListItem.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleListItemViewModel.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleListViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:flutter/material.dart';

class ArticleListStyle {
  final TextStyle titleTextStyle;
  final EdgeInsets titleEdgePadding;
  final bool heroEnabled;

  const ArticleListStyle({
    this.titleTextStyle,
    this.titleEdgePadding,
    this.heroEnabled,
  });

  ArticleListStyle copyWith({
    TextStyle titleTextStyle,
    EdgeInsets titleEdgePadding,
    bool heroEnabled,
  }) {
    return ArticleListStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleEdgePadding: titleEdgePadding ?? this.titleEdgePadding,
      heroEnabled: heroEnabled ?? this.heroEnabled,
    );
  }
}

class _DefaultStyle extends ArticleListStyle {
  final TextStyle titleTextStyle = const TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1a1b46),
  );
  final EdgeInsets titleEdgePadding = const EdgeInsets.only(
    left: 34.0,
    right: 34.0,
    top: 35.0,
    bottom: 30.0,
  );
  final bool heroEnabled = false;

  const _DefaultStyle({
    TextStyle titleTextStyle,
    EdgeInsets titleEdgePadding,
    bool heroEnabled,
  });
}

const ArticleListStyle _defaultStyle = const _DefaultStyle();

class ArticleList extends StatelessWidget {
  static ArticleListStyle defaultStyle = _defaultStyle;
  final ViewModelProvider<ArticleListViewModel> _viewModelProvider;
  final ArticleListStyle _style;

  ArticleList(
      {Key key,
      ViewModelProvider<ArticleListViewModel> viewModelProvider,
      ArticleListStyle style = _defaultStyle})
      : this._style = style,
        this._viewModelProvider = viewModelProvider,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProviderBuilder<ArticleListViewModel>(
      provider: _viewModelProvider,
      successBuilder: _buildSuccess,
    );
  }

  Widget buildHeader({ArticleListViewModel viewModel}) {
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

  IndexedWidgetBuilder bodyListBuilder(
      {List<ArticleListItemViewModel> viewModels}) {
    return (BuildContext context, int index) {
      final viewModel = viewModels[index];
      final tapFunction = () => _tappedListItem(
            context: context,
            viewModel: viewModel.detailViewModel,
          );
      final shouldBuildHero = _style.heroEnabled && (index == 0);

      if (shouldBuildHero) {
        return HeroListItem(
          viewModel: viewModel,
          onTap: tapFunction,
        );
      } else {
        return StandardListItem(
          viewModel: viewModel,
          onTap: tapFunction,
        );
      }
    };
  }

  void _tappedListItem({
    BuildContext context,
    ArticleDetailViewModel viewModel,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ArticleDetail(viewModel: viewModel),
      ),
    );
  }

  Widget _buildSuccess({
    BuildContext context,
    AsyncSnapshot<ArticleListViewModel> snapshot,
  }) {
    final viewModel = snapshot.data;
    return HeaderAndFooterListView(
        itemCount: viewModel.articleListItemViewModels.length,
        itemBuilder:
            bodyListBuilder(viewModels: viewModel.articleListItemViewModels),
        physics: ScrollPhysics(),
        shrinkWrap: true,
        headers: [buildHeader(viewModel: viewModel)]);
  }
}
