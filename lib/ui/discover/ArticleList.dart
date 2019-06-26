import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/discover/HeroListItem.dart';
import 'package:farmsmart_flutter/ui/discover/StandardListItem.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleListViewModel.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';

abstract class ArticleListStyle {
  final TextStyle titleTextStyle;
  final EdgeInsets titleEdgePadding;

  ArticleListStyle(this.titleTextStyle, this.titleEdgePadding);
}

class _ArticleListDefaultStyle implements ArticleListStyle {
  static const Color titleColor = Color(0xFF1a1b46);
  static const Color textColor = Color(0xFF767690);

  final TextStyle titleTextStyle = const TextStyle(
      fontSize: 27, fontWeight: FontWeight.bold, color: titleColor);
  final EdgeInsets titleEdgePadding =
      const EdgeInsets.only(left: 34.0, right: 34.0, top: 35.0, bottom: 30.0);

  const _ArticleListDefaultStyle();
}

class ArticleList extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ArticleList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, ArticleListViewModel>(
          onInit: (store) => store.dispatch(FetchArticlesAction()),
          builder: (_, viewModel) => _buildBody(context, viewModel),
          converter: (store) => ArticleListViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, ArticleListViewModel viewModel) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildList(context, viewModel.articleListItemViewModels);
      case LoadingStatus.ERROR:
        return Text(Strings.errorString);
    }
  }

  Widget _buildList(BuildContext context, List<ArticleListItemViewModel> viewModels,
      {ArticleListStyle articleListStyle = const _ArticleListDefaultStyle()}) {
    return HeaderAndFooterListView.builder(
        itemCount: viewModels.length,
        itemBuilder: (BuildContext context, int index) {
          final viewModel = viewModels[index];
          if (index == 0) {
            return HeroListItem().builder(viewModel);
          } else {
            return StandardListItem().builder(viewModel);
          }
        },
        physics: ScrollPhysics(),
        shrinkWrap: true,
        header: _buildHeader(articleListStyle));
  }

  Widget _buildHeader(ArticleListStyle articleListStyle) {
    return Container(
      padding: articleListStyle.titleEdgePadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(Strings.discoverTab, style: articleListStyle.titleTextStyle)
        ],
      ),
    );
  }
}
