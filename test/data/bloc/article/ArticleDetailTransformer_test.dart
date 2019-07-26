import 'package:farmsmart_flutter/data/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/data/model/mock/MockArticle.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';

final testArticle = MockArticle().build();

void main() {
  test('Article detail viewmodel transfomed from article correctly', () {
    final detailTransformer = ArticleDetailViewModelTransformer();
    final listTransformer = ArticleListItemViewModelTransformer(detailTransformer: detailTransformer);
    detailTransformer.setListItemTransformer(listTransformer);
    
    final articleDetailViewModel = detailTransformer.transform(from: testArticle);
    final publishedDateString = DateFormat("d MMMM").format(testArticle.published);

    expect(articleDetailViewModel.title, testArticle.title);
    expect(articleDetailViewModel.body, testArticle.content);

    final subtitleContainsPublishDate = articleDetailViewModel.subtitle.contains(publishedDateString);
    expect(subtitleContainsPublishDate, true);

    //TODO: add more coverage, sharelink, releated
  });
}