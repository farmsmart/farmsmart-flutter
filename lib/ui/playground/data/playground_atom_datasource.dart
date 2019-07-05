import 'package:farmsmart_flutter/data/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/data/repositories/implementation/MockArticlesRepository.dart';
import 'package:farmsmart_flutter/ui/discover/HeroListItem.dart';
import 'package:farmsmart_flutter/ui/discover/StandardListItem.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';

class PlayGroundAtomDataSource implements PlaygroundDataSource {
  @override
  List<Widget> getList() {
    return [
      //Add your atoms here
      Text('Atom widget 1'),
      Card(child: Text('Atom widget 2')),
      Text('Atom widget 4'),
      StandardListItem(
              viewModel: ArticleListItemViewModelTransformer(
                      detailTransformer:
                          ArticleDetailViewModelTransformer(
                              listItemTransformer:
                                  ArticleListItemViewModelTransformer()))
                  .transform(from: MockArticle.build())),
          HeroListItem(
              viewModel: ArticleListItemViewModelTransformer(
                      detailTransformer:
                          ArticleDetailViewModelTransformer(
                              listItemTransformer:
                                  ArticleListItemViewModelTransformer()))
                  .transform(from: MockArticle.build()))
    ];
  }
}
