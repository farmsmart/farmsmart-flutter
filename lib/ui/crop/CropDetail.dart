import 'package:farmsmart_flutter/data/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:farmsmart_flutter/ui/common/SectionListView.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/article/ArticleDetail.dart';
import 'package:flutter/material.dart';
import 'CropInfoList.dart';

abstract class CropDetailStyle {
  final TextStyle titleTextStyle;
  final EdgeInsets titleEdgePadding;

  CropDetailStyle(
      this.titleTextStyle, this.titleEdgePadding);
  CropDetailStyle copyWith({
    TextStyle titleTextStyle,
    EdgeInsets titleEdgePadding,
  });
}

class _DefaultStyle implements CropDetailStyle {
  final TextStyle titleTextStyle;
  final EdgeInsets titleEdgePadding;

  const _DefaultStyle(
      {TextStyle titleTextStyle,
      EdgeInsets titleEdgePadding})
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
            );

  @override
  CropDetailStyle copyWith({
    TextStyle titleTextStyle,
    EdgeInsets titleEdgePadding,
  }) {
    return _DefaultStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        titleEdgePadding: titleEdgePadding ?? this.titleEdgePadding);
  }
}

const CropDetailStyle _defaultStyle = const _DefaultStyle();

class CropDetail extends StatelessWidget implements ListViewSection {
  final CropDetailStyle _style;
  final ViewModelProvider<CropDetailViewModel> _viewModelProvider;
  final Widget _header;
  SectionedListView _listBuilder;
  CropDetail._({
    Key key,
    ViewModelProvider<CropDetailViewModel> provider,
    CropDetailStyle style,
    SectionedListView listBuilder,
    Widget header,
  })  : this._style = style,
        this._viewModelProvider = provider,
        this._listBuilder = listBuilder,
        this._header = header,
        super(key: key);

  factory CropDetail({ViewModelProvider<CropDetailViewModel> provider,
    CropDetailStyle style = _defaultStyle,}) {
      final listBuilder =  SectionedListView(sections: []);
      return CropDetail._(provider: provider,style: style, listBuilder: listBuilder,);
  }

  @override
  Widget build(BuildContext context) {
    final builder = ViewModelProviderBuilder(provider: _viewModelProvider,successBuilder: _buildSuccess,);
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
      {BuildContext context,
      AsyncSnapshot<CropDetailViewModel> snapshot}) {
    final viewModel = snapshot.data;
    final article = ArticleDetail(viewModel: viewModel, articleHeader: _header,);
    final infoItems = CropInfoList(items: viewModel.infoItems);
    final listBuilder =  SectionedListView(sections:[article,infoItems]);
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
