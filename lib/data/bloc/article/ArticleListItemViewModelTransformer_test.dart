
import 'package:farmsmart_flutter/data/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/data/repositories/implementation/MockArticlesRepository.dart';
import 'package:test/test.dart';

final testArticle = MockArticle.build();

void main() {
  test('Article list item viewmodel transfomed from article correctly', () {
    final detailTransformer = ArticleDetailViewModelTransformer();
    final listTransformer = ArticleListItemViewModelTransformer(detailTransformer: detailTransformer);
    detailTransformer.setListItemTransformer(listTransformer);
    final articleListItemViewModel = listTransformer.transform(from: testArticle);

    expect(articleListItemViewModel.title, testArticle.title);
    expect(articleListItemViewModel.summary, testArticle.summary);

    //TODO: add more coverage, need to add images to the mock
  });
}