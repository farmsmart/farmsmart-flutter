import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:farmsmart_flutter/ui/common/SectionListView.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/article/ArticleDetail.dart';
import 'package:flutter/material.dart';
import 'CropInfoList.dart';

class CropDetail extends StatelessWidget implements ListViewSection {
  final ViewModelProvider<CropDetailViewModel> _viewModelProvider;
  final Widget _header;
  SectionedListView _listBuilder;
  CropDetail._({
    Key key,
    ViewModelProvider<CropDetailViewModel> provider,
    SectionedListView listBuilder,
    Widget header,
  })  :
        this._viewModelProvider = provider,
        this._listBuilder = listBuilder,
        this._header = header,
        super(key: key);

  factory CropDetail(
      {ViewModelProvider<CropDetailViewModel> provider,
      Widget header}) {
    final listBuilder = SectionedListView(sections: []);
    return CropDetail._(
      provider: provider,
      listBuilder: listBuilder,
      header: header,
    );
  }

  @override
  Widget build(BuildContext context) {
    final builder = ViewModelProviderBuilder(
      provider: _viewModelProvider,
      successBuilder: _buildSuccess,
    );
    return builder.build(context);
  }

  @override
  itemBuilder() {
    return _listBuilder.itemBuilder();
  }

  @override
  int itemCount() {
    return _listBuilder.itemCount();
  }

  Widget _buildSuccess(
      {BuildContext context, AsyncSnapshot<CropDetailViewModel> snapshot}) {
    final viewModel = snapshot.data;
    final article = ArticleDetail(
      viewModel: viewModel,
      articleHeader: _header,
      shouldShowArticleImage: (_header == null),
    );
    final infoItems = CropInfoList(items: viewModel.infoItems);
    final listBuilder = SectionedListView(sections: [article, infoItems]);
    _listBuilder = listBuilder;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _listBuilder.build(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return ContextualAppBar(
      shareAction: null,
    ).build(context);
  }
}
